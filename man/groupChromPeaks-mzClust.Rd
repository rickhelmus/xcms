% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/DataClasses.R, R/functions-Params.R,
%   R/methods-Params.R, R/methods-XCMSnExp.R
\docType{class}
\name{groupChromPeaks-mzClust}
\alias{groupChromPeaks-mzClust}
\alias{MzClustParam-class}
\alias{MzClustParam}
\alias{sampleGroups,MzClustParam-method}
\alias{sampleGroups<-,MzClustParam-method}
\alias{ppm,MzClustParam-method}
\alias{ppm<-,MzClustParam-method}
\alias{absMz,MzClustParam-method}
\alias{absMz}
\alias{absMz<-,MzClustParam-method}
\alias{absMz<-}
\alias{minFraction,MzClustParam-method}
\alias{minFraction<-,MzClustParam-method}
\alias{minSamples,MzClustParam-method}
\alias{minSamples<-,MzClustParam-method}
\alias{groupChromPeaks,XCMSnExp,MzClustParam-method}
\title{High resolution peak grouping for single spectra samples}
\usage{
MzClustParam(
  sampleGroups = numeric(),
  ppm = 20,
  absMz = 0,
  minFraction = 0.5,
  minSamples = 1
)

\S4method{sampleGroups}{MzClustParam}(object)

\S4method{sampleGroups}{MzClustParam}(object) <- value

\S4method{ppm}{MzClustParam}(object)

\S4method{ppm}{MzClustParam}(object) <- value

\S4method{absMz}{MzClustParam}(object)

\S4method{absMz}{MzClustParam}(object) <- value

\S4method{minFraction}{MzClustParam}(object)

\S4method{minFraction}{MzClustParam}(object) <- value

\S4method{minSamples}{MzClustParam}(object)

\S4method{minSamples}{MzClustParam}(object) <- value

\S4method{groupChromPeaks}{XCMSnExp,MzClustParam}(object, param, msLevel = 1L)
}
\arguments{
\item{sampleGroups}{A vector of the same length than samples defining the
sample group assignments (i.e. which samples belong to which sample
group). This parameter is mandatory for the \code{PeakDensityParam}
and has to be provided also if there is no sample grouping in the
experiment (in which case all samples should be assigned to the
same group).}

\item{ppm}{\code{numeric(1)} representing the relative mz error for the
clustering/grouping (in parts per million).}

\item{absMz}{\code{numeric(1)} representing the absolute mz error for the
clustering.}

\item{minFraction}{\code{numeric(1)} defining the minimum fraction of samples
in at least one sample group in which the peaks have to be present to be
considered as a peak group (feature).}

\item{minSamples}{\code{numeric(1)} with the minimum number of samples in at
least one sample group in which the peaks have to be detected to be
considered a peak group (feature).}

\item{object}{For \code{groupChromPeaks}: an \link{XCMSnExp} object containing the
results from a previous chromatographic peak detection analysis (see
\code{\link[=findChromPeaks]{findChromPeaks()}}).

\if{html}{\out{<div class="sourceCode">}}\preformatted{For all other methods: a `MzClustParam` object.
}\if{html}{\out{</div>}}}

\item{value}{The value for the slot.}

\item{param}{A \code{MzClustParam} object containing all settings for
the peak grouping algorithm.}

\item{msLevel}{\code{integer(1)} defining the MS level. Currently only MS level
1 is supported.}
}
\value{
The \code{MzClustParam} function returns a \code{MzClustParam} class instance with
all of the settings specified for high resolution single spectra peak
alignment.

For \code{groupChromPeaks}: a \link{XCMSnExp} object with the results of the peak
grouping step (i.e. the features). These can be accessed with the
\code{\link[=featureDefinitions]{featureDefinitions()}} method.
}
\description{
This method performs high resolution correspondence for single spectra
samples.

The \code{MzClustParam} class allows to specify all settings for the peak
grouping based on the \emph{mzClust} algorithm.
Instances should be created with the \code{MzClustParam} constructor.

\code{sampleGroups},\verb{sampleGroups<-}: getter and setter
for the \code{sampleGroups} slot of the object.

\code{ppm},\verb{ppm<-}: getter and setter for the \code{ppm}
slot of the object.

\code{absMz},\verb{absMz<-}: getter and setter for the
\code{absMz} slot of the object.

\code{minFraction},\verb{minFraction<-}: getter and setter for
the \code{minFraction} slot of the object.

\code{minSamples},\verb{minSamples<-}: getter and setter for the
\code{minSamples} slot of the object.

\verb{groupChromPeaks,XCMSnExp,MzClustParam}: performs high resolution peak
grouping for single spectrum metabolomics data.
}
\section{Slots}{

\describe{
\item{\code{sampleGroups,ppm,absMz,minFraction,minSamples}}{See corresponding
parameter above.}
}}

\note{
These methods and classes are part of the updated and modernized
\code{xcms} user interface which will eventually replace the
\code{\link[=group]{group()}} methods. All of the settings to the algorithm
can be passed with a \link{MzClustParam} object.

Calling \code{groupChromPeaks} on an \code{XCMSnExp} object will cause
all eventually present previous correspondence results to be dropped.
}
\examples{

## Loading a small subset of direct injection, single spectrum files
library(msdata)
fticrf <- list.files(system.file("fticr-mzML", package = "msdata"),
                    recursive = TRUE, full.names = TRUE)
fticr <- readMSData(fticrf[1:2], msLevel. = 1, mode = "onDisk")

## Disable parallel processing for this example
register(SerialParam())

## Perform the MSW peak detection on these:
p <- MSWParam(scales = c(1, 7), peakThr = 80000, ampTh = 0.005,
             SNR.method = "data.mean", winSize.noise = 500)
fticr <- findChromPeaks(fticr, param = p)

head(chromPeaks(fticr))

## Now create the MzClustParam parameter object: we're assuming here that
## both samples are from the same sample group.
p <- MzClustParam(sampleGroups = c(1, 1))

fticr <- groupChromPeaks(fticr, param = p)

## Get the definition of the features.
featureDefinitions(fticr)
}
\references{
Saira A. Kazmi, Samiran Ghosh, Dong-Guk Shin, Dennis W. Hill
and David F. Grant\cr Alignment of high resolution mass spectra:
development of a heuristic approach for metabolomics.\cr Metabolomics,
Vol. 2, No. 2, 75-83 (2006)
}
\seealso{
The \code{\link[=do_groupPeaks_mzClust]{do_groupPeaks_mzClust()}} core API function and \code{\link[=group.mzClust]{group.mzClust()}} for
the old user interface.

\code{\link[=featureDefinitions]{featureDefinitions()}} and \code{\link[=featureValues]{featureValues()}} for methods to access peak
grouping results (i.e. the features).

\link{XCMSnExp} for the object containing the results of
the peak grouping.

Other peak grouping methods: 
\code{\link{groupChromPeaks-density}},
\code{\link{groupChromPeaks-nearest}},
\code{\link{groupChromPeaks}()}
}
\concept{peak grouping methods}
