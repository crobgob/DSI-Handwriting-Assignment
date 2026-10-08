# AI use log

Add a row whenever you use an LLM. This is the raw material for the AI use
statement (`sections/_09-ai-use-statement.qmd`), which needs (a) to (d) below
for each task in the brief.

| Date | Who | Task | (a) Tool | (b) Used for | (c) How it was checked | (d) How much was kept |
|------|-----|------|----------|--------------|------------------------|-----------------------|
| 2026-10-02 | Corey | 7, 9 | Claude | Git/GitHub workflow plan; generating the repo skeleton (folders, `_quarto.yml`, `.gitignore`, `R/` helper stubs, README) | | |
| 2026-10-07 | Corey | 2, 7 | Claude | Results caching in `sections/_02-cnn.qmd`: the training chunks run only when `results/cnn_cv.rds` is missing, so a full render reuses saved results and does not retrain the CNN | | |
| 2026-10-08 | Corey | 2, 5, 8 | Claude | Tidying the presentation of results in `sections/_02-cnn.qmd` and `sections/_05-cnn-hpo.qmd`: `knitr::kable` tables with column headings and captions, figure captions and axis labels, `tbl-`/`fig-` labels for cross-referencing, and sub-headings. No change to models, training or results | | |
