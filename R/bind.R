#' Bind
#'
#' @inheritParams purrr::as_function
#' @inheritParams fmap
#' @export
bind <- function(.m, .f, ...) {
  UseMethod("bind")
}
