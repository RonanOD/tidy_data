# Tidy Data

This project contains run_analysis.R: a script for tidying movement data as part of
the Coursera Tidying Data project. See below for details on how to run the
file and load the outputted data back into R.  All variables, their units and
transformations performed on the raw data are included in CookBook.md.

## Requirements

* R version 3.1.1
* The [raw data
  zip file](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip)
downloaded and unziped in the current working directory.
* Package plyr version 1.8.1
* Package reshape2 version 1.4

## How to run the script

1. Download run_analysis.R from github.
1. Download the (dataset)[https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip]
and extract it to the same directory as run_analysis.R.  Do not alter any folder names or file names.
1. Open an R console and set the working directory ("wd") to where you extracted the previous files.
1. Run these R commands to run the script.

```R
setwd("path\to\script_and_data")
source("run_analysis.R")
```
## To view the data output
```R
data <- read.table("tidy_data.txt", header=TRUE, stringsAsFactors = FALSE)
head(data)
```
