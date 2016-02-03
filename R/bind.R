#' Bind
#'
#' @inheritParams purrr::as_function
#' @inheritParams fmap
#' @export
bind <- function(.m, .f, ...) {
  UseMethod("bind")
}

#' @export
bind.reactive <- function(.m, .f, ...) {
  .f <- purrr::as_function(.f)
  .f(.m(), ...)
}
