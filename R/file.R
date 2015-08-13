#' @title Get a Google Doubleclick API report file
#'
#' @param path list including a request parameters.
#' @param query list including a request parameters.
#' @param token \code{\link[httr]{Token2.0}} class object with a valid authorization data.
#'
#' @return A Google Doubleclick API file response.
#'
#' @include auth.R
#' @include url.R
#'
#' @importFrom httr GET config accept_json content
#' @importFrom jsonlite fromJSON
#'
#' @export get_file

get_file<- function(path, token) {
    if (missing(token) && token_exists(getOption("rdfa.token")))
        token <- get_token(getOption("rdfa.token"))
    if (!missing(token)) {
        stopifnot(inherits(token, "Token2.0"))
        config <- config(token = token)
    } else
        config <- NULL
    #resp <- GET(path, accept_json(), config)
    #resp <- GET(path,  accept("text/csv"), config)
    #resp <- POST(path, accept("text/csv"), config)
    #resp <- GET(path, config, write_disk("tmp.csv", overwrite=TRUE))
    resp <- GET(path, config)
    if (resp$status_code == 401L) {
        authorize(cache = FALSE)
        return(eval(match.call()))
    }
    #data_json <- fromJSON(content(resp, as = "text"), simplifyVector = simplify, flatten = flatten)
    #if (!is.null(data_json$error))
    #    error_message(data_json)
    #return(data_json)
    output<-content(resp, as="text")
    return(output)
}
