# RDFA

[![CRAN_Status_Badge](http://www.r-pkg.org/badges/version/RGA)](http://cran.r-project.org/web/packages/RGA/)

This package is designed to work with the [API Google Doubleclick](https://developers.google.com/analytics) in [R](http://www.r-project.org/).

Key features:

* [OAuth 2.0](https://developers.google.com/accounts/docs/OAuth2) authorization;
* Access to the following [Google Analytics APIs](https://developers.google.com/analytics/devguides/platform/):
    - [Management API](https://developers.google.com/analytics/devguides/config/mgmt/v3): access to configuration data for accounts, web properties, views (profiles), goals and segments;
    - [Core Reporting API](https://developers.google.com/analytics/devguides/reporting/core/v3): query for dimensions and metrics to produce customized reports;
    - [Multi-Channel Funnels Reporting API](https://developers.google.com/analytics/devguides/reporting/mcf/v3): query the traffic source paths that lead to a user's goal conversion;
    - [Real Time Reporting API](https://developers.google.com/analytics/devguides/reporting/realtime/v3): report on activity occurring on your property at the moment;
    - [Metadata API](https://developers.google.com/analytics/devguides/reporting/metadata/v3): access the list of API dimensions and metrics and their attributes;
* Access to all the accounts which the user has access to;
* API responses is converted directly into R as a `data.frame`;
* Auto-pagination to return more than 10,000 rows of the results by combining multiple data requests.

## Installation

To install the latest release version from CRAN with:

```r
install.packages("RDFA")
```

To install the development version the `install_bitbucket` function from `devtools` package can be used:

```r
devtools::install_bitbucket(repo = "rdfa", username = "unikum")
```

Another method to install the package `RGA` (using the command line):

```bash
git clone https://unikum@bitbucket.org/unikum/rga.git
R CMD build rdfa
R CMD INSTALL rdfa_*.tar.gz
```

## Usage

Once you have the package loaded, there are 3 steps you need to use to get data from Google Analytics:

1. Authorize this package to access your Google Analytics data with the `authorize()` function.
1. Determine the profile ID which you want to get access to with the `list_profiles()` function.
1. Get the results from the API with one of these functions: `get_ga()`, `get_mcf()` or `get_rt()`. 

For details about this steps please type into R:

```r
browseVignettes(package = "RDFA")
```

## Bug reports

Before posting a bug please try execute your code with the `httr::with_verbose()` wrapper. It will be useful if you attach verbose output to the bug report.

```r
httr::with_verbose(list_profiles())
httr::with_verbose(get_ga("XXXXXXXX"))
```

Post the `traceback()` output also may be helpful.

To report a bug please type into R:

```r
utils::bug.report(package = "RDFA")
```
