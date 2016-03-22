templatePvalueHistogram <- "
## {{{densityVarName}}}

```{r histPval-{{{varName}}}, fig.width=10, fig.height=10, dev=device, warning=FALSE}
p1{{{varName}}} <- ggplot(regions.df.plot, aes(x={{{varName}}}, colour=seqnames)) +
    geom_histogram(binwidth=.05, alpha=.5, position='identity') + xlim(0, 1) +
    labs(title='Histogram of {{{densityVarName}}}') + 
    xlab('{{{densityVarName}}}') +
    scale_colour_discrete(limits=chrs) + theme(legend.title=element_blank())
p1{{{varName}}}
```


```{r 'summary-{{{varName}}}'}
summary(mcols(regions)[['{{{varName}}}']])
```


This is the numerical summary of the distribution of the {{{densityVarName}}}.

```{r tableSummary-{{{varName}}}, results='asis'}
{{{varName}}}table <- lapply(c(1e-04, 0.001, 0.01, 0.025, 0.05, 0.1, 0.2, 0.3, 0.4, 0.5,
    0.6, 0.7, 0.8, 0.9, 1), function(x) {
    data.frame('Cut' = x, 'Count' = sum(mcols(regions)[['{{{varName}}}']] <= x))
})
{{{varName}}}table <- do.call(rbind, {{{varName}}}table)
if(outputIsHTML) {
    kable({{{varName}}}table, format = 'markdown', align = c('c', 'c'))
} else {
    kable({{{varName}}}table)
}
```

This table shows the number of regions with {{{densityVarName}}} less or equal than some commonly used cutoff values. 

"

templateHistogram <- "

## {{{densityVarName}}}

```{r histogram-{{{varName}}}, fig.width=14, fig.height=14, dev=device, eval=hasSignificant, echo=hasSignificant, warning = FALSE}
xrange <- range(regions.df.plot[, '{{{varName}}}'])
p3a{{{varName}}} <- ggplot(regions.df.plot[is.finite(regions.df.plot[, '{{{varName}}}']), ], aes(x={{{varName}}}, fill=seqnames)) +
    geom_histogram(alpha=.5, position='identity') +
    labs(title='Histogram of {{{densityVarName}}}') +
    xlab('{{{densityVarName}}}') +
    xlim(xrange) + theme(legend.title=element_blank())
p3b{{{varName}}} <- ggplot(regions.df.sig[is.finite(regions.df.sig[, '{{{varName}}}']), ], aes(x={{{varName}}}, fill=seqnames)) +
    geom_histogram(alpha=.5, position='identity') +
    labs(title='Histogram of {{{densityVarName}}} (significant only)') +
    xlab('{{{densityVarName}}}') +
    xlim(xrange) + theme(legend.title=element_blank())
grid.arrange(p3a{{{varName}}}, p3b{{{varName}}})
```

```{r histogram-solo-{{{varName}}}, fig.width=10, fig.height=10, dev=device, eval=!hasSignificant, echo=!hasSignificant, warning = FALSE}
p3a{{{varName}}} <- ggplot(regions.df.plot[is.finite(regions.df.plot[, '{{{varName}}}']), ], aes(x={{{varName}}}, fill=seqnames)) +
    geom_histogram(alpha=.5, position='identity') +
    labs(title='Histogram of {{{densityVarName}}}') +
    xlab('{{{densityVarName}}}') +
    theme(legend.title=element_blank())
p3a{{{varName}}}
```

This plot shows the histogram of the {{{densityVarName}}} for all regions. `r ifelse(hasSignificant, 'The bottom panel is restricted to significant regions.', '')`

"
