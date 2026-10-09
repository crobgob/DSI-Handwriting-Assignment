## Functions for Siamese networks

# Function to construct pairs of image indices to compare
# use person_id to decide if positive / negative pair
make_pairs <- function(ids, # indices of images it can use
                       n, # how many pairs to create
                       metadata){ # metadata -> writer ID + digit ID for each image

  # a: choose the first image in every pair - randomly selects n IDs which can be replicated
  a <- sample(ids, n, replace = TRUE)

  # b: create the second image in every pair
  b <- vapply(a, function(i){

    # randomly decide if pair is from same writer or not (should be half of each)
    same <- runif(1) < 0.5

    # finds pool of images with the same digit
    pool <- ids[metadata$digit[ids] == metadata$digit[i]]

    if(same){ # if the same writer, pool must be same writer + same digit (pos pair)

      # 'from all images of digit i, keep only the ones written by the same writer'
      pool <- pool[metadata$person_id[pool] == metadata$person_id[i]]# who wrote image i

    } else { # if not the same writer, pool must be diff writer + same digit (neg pair)

      pool <- pool[metadata$person_id[pool] != metadata$person_id[i]]

    }
    sample(setdiff(pool, i), 1) # doesn't allow pairing with itself

  }, integer(1)) # each iteration must return 1 integer

  cbind(a,b)
}

# Function to extract images from the pairs of image indices
make_batch <- function(p, # pairs created by make_pairs()
                       images = x, # actual images
                       class_labels = y_person) { # class assoc with images

  y <- matrix(as.integer( # true = 1, false = 0
    class_labels[p[, 1]] # labels of first col of p-i matrix
    == class_labels[p[, 2]]), # label of second col
    ncol = 1) # matrix of 1 col for formatting for neural network

  # return the actual images + the target
  list(
    left = images[p[, 1], , , , drop = FALSE], # left side of Siamese (first image of pair)
    right = images[p[, 2], , , , drop = FALSE], # right side of Siamese (second image of pair)
    y = y
  )
}

# Function to calculate contrastive loss
contrastive_loss <- function(y, d) {
  op_mean( # finds avg loss across all pairs in a batch
    y * op_square(d) + # squares each pair's distance - for same-writer pairs, penalises a large distance
      (1 - y) * op_square(op_maximum(1 - d, 0))) # for diff writer pairs, penalises only if distance is < 1: if dist >=1, penalty is 0
}

# Function to calculate balanced accuracy at different thresholds
balanced_accuracy_at <- function(cut) {
  predicts_same <- valid_distance < cut # at given threshold (cut) would model predict same or different?
  same_rate <- mean(predicts_same[valid_same]) # accuracy for "same" pairs
  different_rate <- mean(!predicts_same[!valid_same]) # accuracy for "different" pairs
  (same_rate + different_rate) / 2 # mean accuracy for "same" and "different" ("alanced accuracy)
}
