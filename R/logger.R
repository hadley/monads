#' A list where all elements are the same class.
#'
#' @param value Value with logging context
#' @param log Character vector of logged values.
#' @param ... Elements to combine into a list. All elements must be the
#'   same type.
#' @export
#' @examples
#' (l <- logger(5, "object created"))
#' (l2 <- l %>>% `*`(2))
#'
#' set_value <- function(x, y) {
#'   logger(y, paste(x, "->", y))
#' }
#'
#' l2 %>+% set_value(20)
logger <- function(value, log = character()) {
  structure(list(value = value, log = log), class = "logger")
}

#' @export
fmap.logger <- function(.m, .f, ...) {
  out <- .f(.m$value, ...)
  logger(out, .m$log)
}

#' @export
bind.logger <- function(.m, .f, ...) {
  out <- .f(.m$value, ...)
  logger(out$value, c(out$log, .m$log))
}

#' @export
join.logger <- function(.m) {
  logger(.m$value$value, c(.m$value$log, .m$log))
}

#' @export
print.logger <- function(x, ...) {
  print(x$value)

  cat("Log: \n")
  cat(paste("* ", x$log, "\n"), "\n", sep = "")
}
