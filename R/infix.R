#' Infix fmap and bind.
#'
#' This works like magrittr's \code{\%>\%}, but uses fmap to unwrap, apply,
#' and then rewrap the object.
#'
#' @param lhs A monad
#' @param rhs Call to invoke.
#' @rdname infix
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
  call <- inline_call(quote(fmap), substitute(lhs), substitute(rhs))
  eval(call, parent.frame())
}

#' @export
#' @rdname infix
"%>+%" <- function(lhs, rhs) {
  call <- inline_call(quote(bind), substitute(lhs), substitute(rhs))
  eval(call, parent.frame())
}

inline_call <- function(f, lhs, rhs) {
  if (singular_form(rhs)) {
    call <- as.call(c(f, lhs, rhs))
  } else {
    call <- as.call(c(f, lhs, rhs[[1]], as.list(rhs[-1])))
  }
  call
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
