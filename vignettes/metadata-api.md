---
title: "Obtain access to the Metadata API"
#author: "Artem Klevtsov"
#date: "2015-08-11"
output: rmarkdown::html_vignette
vignette: >
  %\VignetteIndexEntry{Metadata API}
  %\VignetteEngine{knitr::rmarkdown}
  %\VignetteDepends{RGA}
  %\VignetteEncoding{UTF-8}
---



When working with the API reports it is sometimes necessary to obtain background information about these or other query parameters to the API. To obtain a list of all the metrics and dimensions `RGA` package provides the `list_metadata()` function, which return actual informtation about all dimensions and metrics for the given report type (now support only the Core Reporting API metadata).

`list_metadata()` return an `data.frame`,  which consists of the following columns:

* `id` - the parameter code name (metric or dimension) (used for queries);
* `type` - parameter type: metric (METRIC) or dimension (DIMENSION);
* `data.type` - data type: STRING, INTEGER, PERCENT, TIME, CURRENCY, FLOAT;
* `group` - group of parameters (ex. User, Session, Traffic Sources);
* `status` - status: actual (PUBLIC) or outdated (DEPRECATED);
* `ui.name` - parameter name (not used for queries);
* `description` - parameter description;
* `allowed.in.segments` - whether the parameter can be used in the segments;
* `replaced.by` - name of the replacement parameter, if the parameter is deprecated;
* `calculation` - formula of calculating the parameter value, if the parameter is calculated based on other parameters;
* `min.template.index` - if the parameter contains a numeric index, the minimum parameter index;
* `max.template.index` - if the parameter contains a numeric index, the maximum parameter index;
* `premium.min.template.index` - if the parameter contains a numeric index, a minimum index for the parameter;
* `premium.max.template.index` - if the parameter contains a numeric index, a maximum index for the parameter.

There are several examples of usage the metadata Google Analytics API.

## Examples

To obtain the relevant information metadata:

```r
ga_meta <- list_metadata()
```

List of all outdated parameters and those ones which were replaced:

```r
subset(ga_meta, status == "DEPRECATED", c(id, replaced.by))
```

List of all parameters from certain group:

```r
subset(ga_meta, group == "Traffic Sources", c(id, type))
```

List of all calculated parameters:

```r
subset(ga_meta, !is.na(calculation), c(id, calculation))
```

List of all parameters allowed in segments:

```r
subset(ga_meta, allowed.in.segments, id)
```

List of all templatized parameters:

```r
subset(ga_meta, !is.na(min.template.index) & !is.na(max.template.index), id)
```

`RGA` package also provide the shiny demo app to access `ga` dataset:

```r
dimsmets("ga")
```

## References

- [Dimensions & Metrics Reference](https://developers.google.com/analytics/devguides/reporting/core/dimsmets)
- [Metadata API - Developer Guide](https://developers.google.com/analytics/devguides/reporting/metadata/v3/devguide)
