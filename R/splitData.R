## Split data for Siamese network fitting and hyperparameter tuning

set.seed(25) # set seed for reproducibility

# Original writer IDs
writers <- unique(handwriting$metadata$person_id)

# 60 % of all writers to train
train_writers <- sample(writers, 0.6*length(writers))

# 20 % of all writers to each of validate and test
rest_writers <- setdiff(writers, train_writers)
valid_writers <- sample(rest_writers, 0.5*length(rest_writers))
test_writers <- setdiff(rest_writers, valid_writers)

# Extract the image IDs belonging to each split
train_ids <- which(handwriting$metadata$person_id %in% train_writers)
valid_ids <- which(handwriting$metadata$person_id %in% valid_writers)
test_ids <- which(handwriting$metadata$person_id %in% test_writers)

# Extract pairs of image indices in each set
# using make_pairs fn from siameseFunctions.R
train_pairs <- make_pairs(train_ids, length(train_ids), handwriting$metadata)
valid_pairs <- make_pairs(valid_ids, length(valid_ids), handwriting$metadata)
test_pairs <- make_pairs(test_ids, length(test_ids), handwriting$metadata)

# Extract pairs of actual images and 0/1 using the indices in each set
# using make_batch fn from siameseFunctions.R
train <- make_batch(train_pairs)
valid <- make_batch(valid_pairs)
test  <- make_batch(test_pairs)
