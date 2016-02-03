#' fmap: unwrap, apply function, and rewrap.
#'
#' Any object with a \code{fmap} method is called a \code{functor}.
#'
#' @param .m The monad
#' @inheritParams purrr::as_function
#' @param ... Additonal arguments passed on to \code{.f}.
#' @export
#' @examples
#' # Functions are functors
#' add1 <- function(x) x + 1
#' add2 <- function(x) x + 2
#'
#' add3 <- add1 %>>% add2
#' add3(10)
fmap <- function(.m, .f, ...) {
  UseMethod("fmap", .m)
}
