# DSI Handwriting Assignment

STA5073Z Data Science for Industry 2026, Assignment 2: writer identification
from handwritten digits with a CNN and a Siamese network. The brief is
`DS4I_2026_Assignment_2_NNs.pdf`.

## Setup

1. Clone the repo and open `DSI-Handwriting-Assignment.Rproj`.
3. Use the same versions as the rest of the group:

   | Tool       | Version |
   |------------|---------|
   | R          | 4.6.1   |
   | Quarto     | 1.10.18 |
   | Python     | 3.12.15 |
   | TensorFlow | 2.21    |

   R packages will be pinned in `renv.lock` (not created yet). Once it exists,
   run `renv::restore()` after cloning.
   Both CNNs and Siamese networks were fitted using the Keras framework via the *keras3* R package using the TensorFlow backend. The tidyverse package was utilised throughout the analysis for data manipulation and plotting using *ggplot2.*

## Layout

| Path          | Contents                                                          
|---------------|------------------------------------------------------------
| `index.qmd`   | The report. Pulls in the files in `sections/`                     
| `sections/`   | One file per report section                                       
| `R/`          | Shared code: data loading, the split, pair construction           
| `_freeze/`    | Stored results of executed code, reused on render                 
| `data/`       | `handwriting.rds`                                                 
| `_site/`      | Rendered website                                                 

All paths in code are relative to the repo root.


## Rendering

There are two render commands and they behave differently:

```bash
quarto render index.qmd   # re-executes all code and updates _freeze/
quarto render             # reuses _freeze/ and executes nothing unless index.qmd itself changed
```

After editing anything in `sections/` or `R/`, run `quarto render index.qmd`
and commit the updated `_freeze/` with your PR. A plain `quarto render` does
not notice changes in those files and will silently show the old output.

Set a seed with `keras3::set_random_seed()` at the top of each modelling chunk.

## Publishing

From an up-to-date `master`, after merging:

```bash
quarto publish gh-pages
```

This renders from `_freeze/` and pushes the site to the `gh-pages` branch.
