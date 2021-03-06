% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/geneSetTests.R
\name{runQgen}
\alias{runQgen}
\title{Run Q-Gen (generalized QuSAGE) algorithm using gene level statistics}
\usage{
runQgen(model.results, gene.sets, annotations = NULL)
}
\arguments{
\item{model.results}{object returned by \code{genModelResults}.}

\item{gene.sets}{list of gene sets. See \code{\link{genModelResults}} for more
formatting details.}

\item{annotations}{A data frame of additional annotations for the gene sets. 
See \code{\link{genModelResults}} for more formatting details.}
}
\value{
\code{qusage.results} Tall formatted matrix of results

\code{lower.ci} Matrix of gene level lower 95\% confidence intervals

\code{upper.ci} Matrix gene level upper 95\% confidence intervals

\code{gene.sets} List of gene sets provided to \code{gene.sets}

\code{annotations} data frame of gene set annotations. Default is 
  NULL.
}
\description{
Run Q-Gen (generalized QuSAGE) algorithm using gene level statistics
}
\details{
This function takes the gene level comparison estimates and test 
  statistics contained in the object returned by 
  \code{\link{genModelResults}} and runs the Q-Gen algorithm across all of 
  the comparisons. The VIFs are estimated using the raw residuals, which are 
  also contained in the output of \code{\link{genModelResults}}.
}
\examples{
# Example data
data(tb.expr)
data(tb.design)

# Use first 100 probes to demonstrate
dat <- tb.expr[1:100,]

# Create desInfo object
meta.data <- metaData(y = dat, design = tb.design, data.type = "microarray", 
                    columnname = "columnname", long = TRUE, subject.id = "monkey_id",
                    baseline.var = "timepoint", baseline.val = 0, time.var = "timepoint", 
                    sample.id = "sample_id")

# Generate lmFit and eBayes (limma) objects needed for genModelResults
tb.design$Group <- paste(tb.design$clinical_status,tb.design$timepoint, sep = "")
grp <- factor(tb.design$Group)
design2 <- model.matrix(~0+grp)
colnames(design2) <- levels(grp)
dupcor <- limma::duplicateCorrelation(dat, design2, block = tb.design$monkey_id)
fit <- limma::lmFit(dat, design2, block = tb.design$monkey_id, 
                    correlation = dupcor$consensus.correlation)
contrasts <- limma::makeContrasts(A_20vsPre = Active20-Active0, A_42vsPre = Active42-Active0, 
                                  levels=design2)
fit2 <- limma::contrasts.fit(fit, contrasts)
fit2 <- limma::eBayes(fit2, trend = FALSE)

# Create model results object for runQgen
model.results <- genModelResults(y = dat, data.type = "microarray", object = fit2, lm.Fit = fit, 
                                 method = "limma")
                               
# Run Q-Gen on baylor modules                             
data(modules)
qus.results <- runQgen(model.results, modules)
}
