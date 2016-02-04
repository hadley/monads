#' A list where all elements are the same class.
#'
#' @param ... Elements to combine into a list. All elements must be the
#'   same type.
#' @export
#' @examples
#' x <- listOf(1L, 2L, 4:10)
#' double <- function(x) x * 2
#' x %>>% double()
#'
#' x %>>% function(x) list(x, x)
#' x %>+% function(x) list(x, x)
listOf <- function(...) {
  x <- list(...)

  classes <- purrr::map(x, class)
  if (length(unique(classes)) > 1) {
    stop("All elements must have identical classes.", call. = FALSE)
  }

  structure(x, class = "listOf")
}

#' @export
fmap.listOf <- function(.m, .f, ...) {
  structure(purrr::map(.m, .f, ...), class = "listOf")
}

#' @export
bind.listOf <- function(.m, .f, ...) {
  out <- purrr::map(.m, .f, ...)
  stopifnot(is.list(out))

  join.listOf(out)
}

#' @export
join.listOf <- function(.m) {
  structure(purrr::flatten(.m), class = "listOf")
}

#' @export
print.listOf <- function(x, ...) {
  class <- paste(class(x[[1]]), collapse = "/")
  cat("ListOf<", class, ">\n\n", sep = "")
  print(unclass(x))
}
