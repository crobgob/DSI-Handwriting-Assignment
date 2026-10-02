# Read handwriting.rds and scale pixel values to [0, 1].
# Returns a list: x (25000 x 28 x 28 x 1 array) and metadata (one row per image).
load_handwriting <- function(path = "data/handwriting.rds") {
  if (!file.exists(path)) {
    stop("Cannot find ", path, ". Copy handwriting.rds into data/ (see README).",
         call. = FALSE)
  }
  data <- readRDS(path)
  list(x = data$images / 255, metadata = data$metadata)
}
