# The one train/validation/test split, shared by every model.
# make_splits() is run once; its result is saved to splits/ and committed, and
# all modelling code calls read_splits() instead of regenerating the indices.

SPLIT_SETS <- c("train", "val", "test")

# TODO (task 4): implement the agreed strategy.
# Must return a named list (train, val, test) of image_id vectors.
make_splits <- function(metadata, seed) {
  stop("make_splits() is not implemented yet: agree the split strategy first.",
       call. = FALSE)
}

check_splits <- function(splits) {
  if (!setequal(names(splits), SPLIT_SETS)) {
    stop("splits must be a list named: ", toString(SPLIT_SETS), call. = FALSE)
  }
  ids <- unlist(splits, use.names = FALSE)
  if (anyDuplicated(ids)) {
    stop("an image_id appears more than once across train/val/test", call. = FALSE)
  }
  invisible(splits)
}

# One image_id per line, so changes to a split show up as a readable diff.
write_splits <- function(splits, dir = "splits") {
  check_splits(splits)
  for (set in SPLIT_SETS) {
    writeLines(as.character(splits[[set]]), file.path(dir, paste0(set, ".txt")))
  }
  invisible(splits)
}

read_splits <- function(dir = "splits") {
  files <- file.path(dir, paste0(SPLIT_SETS, ".txt"))
  if (!all(file.exists(files))) {
    stop("No saved split in ", dir, "/. Run make_splits() and write_splits() once.",
         call. = FALSE)
  }
  splits <- lapply(files, function(f) as.integer(readLines(f)))
  names(splits) <- SPLIT_SETS
  check_splits(splits)
}
