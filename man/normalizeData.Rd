% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/normalizeData.R
\name{normalizeData}
\alias{normalizeData}
\title{Data Normalization}
\usage{
normalizeData(meta, norm.method = "mean")
}
\arguments{
\item{meta}{list returned by \code{metaData}}

\item{norm.method}{String denoting whether to normalize to the mean or median 
of all samples or a control group specified in \code{meta}. Default is
norm.method = "mean".}
}
\value{
\code{y1b} data frame of baseline samples normalized according to 
  \code{norm.method}. NULL if baseline samples are not specified in 
  \code{meta}.

\code{y2b} data frame of baseline samples normalized to controls 
  according to \code{norm.method}. NULL if control samples are not specified 
  in \code{meta}.

\code{y1} data frame of all samples normalized according to 
  \code{norm.method}.

\code{y2} data frame of all samples normalized to controls according 
  to \code{norm.method}. NULL if control samples are not specified in 
  \code{meta}.

\code{y3} data frame of all samples normalized to their baseline. 
  NULL if study is not longitudinal or if baseline samples are not specified 
  in \code{meta}.

\code{norm.method} string describing normalization method used.
}
\description{
Perform various normalizations of expression data
}
\details{
This function performs various normalizations of the expression 
  data, depending on the study design and the parameters defined in 
  \code{\link{metaData}}. For all study designs, the data is normalized to 
  the mean (or median) of all the samples. For cross-sectional studies with 
  controls, an additional normalization to the mean (or median) of the 
  controls is performed. For longitudinal designs, baseline normalization (
  subtract out each subject's baseline) and normalization to the mean (or 
  median) of controls (if present) is performed. In addition, separate 
  normalizations on baseline samples is performed.
}
\examples{
# Example data
data(tb.expr)
data(tb.design)

# Use first 100 probes to demonstrate
dat <- tb.expr[1:100,]

# Create desInfo object
meta.data <- metaData(y = dat, design = tb.design, data.type = "microarray", 
                    columnname = "columnname", long = TRUE, sample.id = "sample_id",
                    subject.id = "monkey_id", time.var = "timepoint",
                    baseline.var = "timepoint", baseline.val = 0)

# Normalize and cluster data
data.norm <- normalizeData(meta = meta.data)
}
