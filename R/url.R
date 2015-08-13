base_api_url <- "https://www.googleapis.com/analytics"
base_api_url_dfa <- "https://www.googleapis.com/dfareporting"
#/v2.2/userprofiles/1597900/reports/23900310?key=
base_api_version <- "v3"
base_api_version_dfa <- "v2.2"

dfaProfileId<-"1597900"

# Convert query list to the string
#' @importFrom curl curl_escape
#' @include utils.R
prepare_query <- function(query) {
    query <- compact(query)
    params <- names(query)
    params <- sub("profile.id", "ids", params, fixed = TRUE)
    params <- sub("sampling.level", "samplingLevel", params, fixed = TRUE)
    params <- gsub(".", "-", params, fixed = TRUE)
    values <- as.character(query)
    values <- enc2utf8(values)
    values <- curl_escape(values)
    query <- paste(params, values, sep = "=", collapse = "&")
    return(query)
}

# Build URL for Google Analytics request
get_url <- function(type = c("ga", "mcf", "rt", "mgmt","dfa"), path = NULL, query = NULL, reportId = NULL, reportCMD=NULL, fileId=NULL) {
    type <- match.arg(type)
    type <- switch(type,
                  ga = "data/ga",
                  mcf = "data/mcf",
                  rt = "data/realtime",
                  mgmt = "management",
                  dfa = "userprofiles")
    if (type=="userprofiles") {
        url <- paste(base_api_url_dfa, base_api_version_dfa, type, dfaProfileId, "reports",  sep = "/")
        if (!is.null(reportId)) {
            if (reportCMD=="run") {
                url <- paste(base_api_url_dfa, base_api_version_dfa, type, dfaProfileId, "reports", reportId, "run",  sep = "/")
            }
            else if (reportCMD=="files") {
                url <- paste(base_api_url_dfa, base_api_version_dfa, type, dfaProfileId, "reports", reportId, "files?sortOrder=DESCENDING",  sep = "/")
            }
            else if (reportCMD=="get") {
                url <- paste(base_api_url_dfa, base_api_version_dfa, type, dfaProfileId, "reports", reportId, "files", fileId,  sep = "/")
            }

        } else {
            url <- paste(base_api_url_dfa, base_api_version_dfa, type, dfaProfileId, "reports",  sep = "/")
        }
    }else{
        url <- paste(base_api_url, base_api_version, type, sep = "/")
    }
    if (!is.null(path)) {
        path <- gsub("\\s", "", path)
        url <- paste(url, path, sep = "/")
    }
    if (!is.null(query)) {
        if (is.list(query))
            query <- prepare_query(query)
        url <- paste(url, query, sep = "?")
    }
    return(url)
}

