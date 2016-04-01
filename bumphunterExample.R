## Script for creating a backup of the bumphunterExample in case that it's not
## available via Bioconductor.

file.copy(file.path('..', 'regionReport', 'vignettes', 'bumphunterExample.Rmd'), '.', overwrite = TRUE)

original <- readLines('bumphunterExample.Rmd')
new <- gsub('bumphunterExampleOutput.html', '/regionReportSupp/bumphunter-example/index.html', original)
new <- gsub('bumphunterExampleOutput', 'index', new)
i <- grep('regionReportBumphunter.Rmd', new)
new[i] <- gsub('regionReportBumphunter.Rmd', file.path(getwd(),
    'bumphunter-example', 'regionReportBumphunter.Rmd'), new[i])
new <- new[-grep('case the link does not work', new)]
new <- gsub("outdir = '.'", "outdir = 'bumphunter-example'", new)

writeLines(new[-c(8:11)], 'bumphunterExample.Rmd')

dir.create('bumphunter-example', showWarnings = FALSE)
rmarkdown::render('bumphunterExample.Rmd')
file.remove('bumphunter-example/index.Rmd')
