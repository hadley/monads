#' @export
fmap.function <- function(.m, .f, ...) {
  function(...) {
    .f(.m(...))
  }
}

#' @export
bind.function <- function(.m, .f, ...) {
  .f(.m(...))
}
