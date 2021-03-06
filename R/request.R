# Error printing function
#' @include utils.R
#' @importFrom httr http_status
#' @importFrom utils capture.output
error_message <- function(x) {
    code <- x$error$code
    message <- http_status(code)$message
    reasons <- x$error$errors[, -1L]
    reasons$reason <- to_separated(reasons$reason, sep = " ")
    reasons <- paste(capture.output(print(reasons, right = FALSE)), collapse = "\n")
    stop(message, "\n", reasons, call. = FALSE)
}

#' @title Get a Google Doubleclick API response
#'
#' @param type character string including report type.
#' @param path list including a request parameters.
#' @param query list including a request parameters.
#' @param simplify logical. Coerce JSON arrays to a vector, matrix or data frame.
#' @param flatten logical. Automatically flatten nested data frames into a single non-nested data frame.
#' @param token \code{\link[httr]{Token2.0}} class object with a valid authorization data.
#'
#' @return A list contatin Google Doubleclick API response.
#'
#' @include auth.R
#' @include url.R
#'
#' @importFrom httr GET config accept_json content
#' @importFrom jsonlite fromJSON
#'
#' @export get_response
get_response <- function(type = c("ga", "rt", "mcf", "mgmt","dfa"), path = NULL, query = NULL, reportId=NULL, reportCMD=NULL, fileId=NULL,
                         simplify = TRUE, flatten = TRUE, token) {
    type <- match.arg(type)
    url <- get_url(type = type, path = path, query = query, reportId = reportId, reportCMD = reportCMD, fileId=fileId)
    print(paste("url->",url))
    if (missing(token) && token_exists(getOption("rdfa.token")))
        token <- get_token(getOption("rdfa.token"))
    if (!missing(token)) {
        stopifnot(inherits(token, "Token2.0"))
        config <- config(token = token)
    } else
        config <- NULL

    if (!is.null(reportCMD) && (reportCMD=="run")) {
        resp <- POST(url, accept_json(), config)
    } else {
        resp <- GET(url, accept_json(), config)
    }

    if (resp$status_code == 401L) {
        authorize(cache = FALSE)
        return(eval(match.call()))
    }
    data_json <- fromJSON(content(resp, as = "text"), simplifyVector = simplify, flatten = flatten)
    if (!is.null(data_json$error))
        error_message(data_json)
    return(data_json)
}

