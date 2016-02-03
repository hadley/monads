#' fmap: unwrap, apply function, and rewrap.
#'
#' @param .m The monad
#' @inheritParams purrr::as_function
#' @param ... Additonal arguments passed on to \code{.f}.
#' @export
fmap <- function(.m, .f, ...) {
  UseMethod("fmap", .m)
}

#' @export
fmap.default <- function(.m, .f, ...) {
  .f <- purrr::as_function(.f)
  .f(.m, ...)
}

#' @export
fmap.list_of <- function(.m, .f, ...) {
  .f <- purrr::as_function(.f)
  purrr::map(.m, .f, ...)
}

#' @export
fmap.reactive <- function(.m, .f, ...) {
  .f <- purrr::as_function(.f)
  shiny::reactive(.f(.m(), ...))
}
