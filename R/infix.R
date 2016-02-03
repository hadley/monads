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
#' }
"%>>%" <- function(lhs, rhs) {
  lhs <- substitute(lhs)
  rhs <- substitute(rhs)

  call_fmap <- as.call(c(quote(fmap), lhs, rhs[[1]], as.list(rhs[-1])))
  eval(call_fmap, parent.frame())
}
