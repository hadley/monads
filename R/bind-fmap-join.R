#' Monad generics.
#'
#' To make a class a monad, you need to define three generics: \code{fmap},
#' \code{bind}, and \code{join}. \code{fmap} takes a non-monad function,
#' and applies it to a monad by unwrapping, applying, and rewrapping.
#' \code{bind} apply a function that takes a regular value and returns a monad,
#' by unwrapping and applying. \code{join} collapses a monad that's nested
#' inside itself.
#'
#' Any object with a \code{fmap} method is called a \code{functor}.
#'
#' @param .m The monad
#' @inheritParams purrr::as_function
#' @param ... Additonal arguments passed on to \code{.f}.
#' @examples
#' # Functions are functors
#' add1 <- function(x) x + 1
#' add2 <- function(x) x + 2
#'
#' add3 <- add1 %>>% add2
#' add3(10)
#' @name monad-generics
NULL

#' @rdname monad-generics
#' @export
fmap <- function(.m, .f, ...) {
  UseMethod("fmap", .m)
}

#' @rdname monad-generics
#' @export
bind <- function(.m, .f, ...) {
  UseMethod("bind")
}

#' @rdname monad-generics
#' @export
join <- function(.m) {
  UseMethod("join")
}
