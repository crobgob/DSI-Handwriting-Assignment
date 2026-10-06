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
   | Python     | TBD     |
   | TensorFlow | TBD     |

   R packages will be pinned in `renv.lock` (not created yet). Once it exists,
   run `renv::restore()` after cloning.

## Layout

| Path          | Contents                                                          | In git |
|---------------|-------------------------------------------------------------------|--------|
| `index.qmd`   | The report. Pulls in the files in `sections/`                     | yes    |
| `sections/`   | One file per report section                                       | yes    |
| `R/`          | Shared code: data loading, the split, pair construction           | yes    |
| `splits/`     | Saved train/val/test `image_id`s, read by every model             | yes    |
| `_freeze/`    | Stored results of executed code, reused on render                 | yes    |
| `ai-log.md`   | Running log for the AI use statement                              | yes    |
| `data/`       | `handwriting.rds`                                                 | no     |
| `models/`     | Saved model weights                                               | no     |
| `_site/`      | Rendered website                                                  | no     |

All paths in code are relative to the repo root.

## Workflow

`master` always renders. All work goes through a short-lived branch and a pull
request with one approval.

```bash
git switch master && git pull
git switch -c siamese-pairs
# small commits as you go
git push -u origin siamese-pairs     # then open a PR
```

- One PR does one thing and links its issue (`Closes #12`).
- The reviewer renders the report, not just reads the diff.
- Merge with a regular merge commit, not squash.
- Methodological decisions are discussed in the issue thread.
- Log LLM use in `ai-log.md` as you go.

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
