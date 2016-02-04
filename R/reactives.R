#' @export
fmap.reactive <- function(.m, .f, ...) {
  .f <- purrr::as_function(.f)
  shiny::reactive(.f(.m(), ...))
}

#' @export
bind.reactive <- function(.m, .f, ...) {
  join(fmap(.m, .f, ...))
}

#' @export
join.reactive <- function(.m) {
  shiny::reactive(.m()())
}
