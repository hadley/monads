#' Infix fmap: allows you to apply an arbitrary function to a wrapped object.
#'
#' This works like magrittr's \code{\%>\%}, but uses fmap to unwrap, apply,
#' and then rewrap the object.
#'
#' @param lhs A monad
#' @param rhs Call to invoke.
#' @rdname infix-fmap
#' @export
#' @examples
#' if (require("shiny")) {
#' options(shiny.suppressMissingContextError = TRUE)
#' r <- reactive(iris)
#' r2 <- r %>>% head(5)
#' r2()
#'
#' double <- function(x) x * 2
#' maybe(10) %>>% double
#' maybe(10) %>>% double()
#' maybe(10) %>>% function(x) x * 2
#' }
"%>>%" <- function(lhs, rhs) {
  lhs <- substitute(lhs)
  rhs <- substitute(rhs)

  if (singular_form(rhs)) {
    call_fmap <- as.call(c(quote(fmap), lhs, rhs))
  } else {
    call_fmap <- as.call(c(quote(fmap), lhs, rhs[[1]], as.list(rhs[-1])))
  }

  eval(call_fmap, parent.frame())
}

singular_form <- function(x) {
  if (is.name(x))
    return(TRUE)

  x <- x[[1]]
  if (identical(x, quote(`function`)))
    return(TRUE)

  if (identical(x, quote(`(`)))
    return(TRUE)

  if (identical(x, quote(`{`)))
    return(TRUE)

  FALSE
}
