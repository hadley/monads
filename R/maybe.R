#' Maybe there is something here?
#'
#' Or maybe there's just a \code{NULL}.
#'
#' @param x Is there something here? Maybe.
#' @export
#' @examples
#' double <- function(x) x * 2
#' maybe(10) %>>% double()
#' nothing() %>>% double()
maybe <- function(x) {
  structure(list(x), class = "maybe")
}

#' @export
#' @rdname maybe
nothing <- function() {
  maybe(NULL)
}

#' @export
fmap.maybe <- function(.m, .f, ...) {
  if (is.null(.m[[1]])) {
    return(.m)
  }

  maybe(.f(.m[[1]], ...))
}

#' @export
bind.maybe <- function(.m, .f, ...) {
  if (is.null(.m[[1]])) {
    return(.m)
  }

  .f(.m[[1]], ...)
}

#' @export
print.maybe <- function(x, ...) {
  if (is.null(x[[1]])) {
    cat("<NOTHING>\n")
  } else {
    cat("<Maybe>\n")
    print(unclass(x[[1]]))
  }
}
