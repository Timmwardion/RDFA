.onLoad <- function(libname, pkgname) {
    op <- options()
    op.rdfa <- list(
        rdfa.client.id = "166370680579-7tj8fkjdrio7uf9vn0mbockcb7oo8ork.apps.googleusercontent.com",
        rdfa.client.secret = "T2W-EOBLczSkpVJbHo2tvEPm",
        rdfa.cache = ".rdfa-token.rds",
        rdfa.token = "RDFAToken"
    )
    toset <- !(names(op.rdfa) %in% names(op))
    if (any(toset)) options(op.rdfa[toset])

    invisible()
}
