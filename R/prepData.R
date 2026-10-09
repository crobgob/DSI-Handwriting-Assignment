## Prep data

# Read in data
handwriting <- readRDS("data/handwriting.rds")

# Prep data for Siamese network
x <- handwriting$images / 255 # scale the pixels to 0-1

y_person <- handwriting$metadata$person_id - 1L # subtracts 1 from every value in ID
# range(y_person) # 0 19 = 20 people
