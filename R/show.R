#' Show Pixels
#' 
#' Creates an HTMLWidget to show pixels.
#' 
#' @param pixels The pixels to render as a 1-dimensional vector, row-first
#'   order expected.
#' @param grid The grid dimensions specified as a \code{c(width, height)} vector.
#' @param size The canvas dimensions specified as a \code{c(width, height)} vector.
#' @param brush The brush specified as a matrix.
#' @param params A set of parameters to customize the visual appearance.
#' 
#' @examples 
#' 
#' library(pixels)
#' show_pixels(
#'   round(runif(400, 0, 1)),
#'   grid = c(40, 10),
#'   size = c(800, 200),
#'   params = list(fill = list(color = "#FF3388"))
#' )
#' 
#' @import htmlwidgets
#' @export
show_pixels <- function(
  pixels = NULL,
  grid = c(28, 28),
  size = c(250, 250),
  brush = matrix(c(
    0.0,0.5,0.8,0.5,0.0,
    0.5,1.0,1.0,1.0,0.5,
    0.8,1.0,1.0,1.0,0.8,
    0.5,1.0,1.0,1.0,0.5,
    0.0,0.5,0.8,0.5,0.0
  ), 5, 5),
  params = list(
    fill = list(color = "#555555"),
    grid = list(color = "#EEEEEE")
  )) {
  
  if (length(grid) != 2) stop("Parameter 'grid' must have only two entries.")
  if (length(size) != 2) stop("Parameter 'size' must have only two entries.")
  
  if (!is.null(pixels) && grid[[1]] * grid[[2]] != length(pixels))
    stop(
      "Parameter 'grid' of ", grid[[1]], "x", grid[[2]], " ",
      "length must match the 'pixels' length of ", length(pixels), ".")
  
  x <- list(
    pixels = pixels,
    gridX = grid[[1]],
    gridY = grid[[2]],
    width = size[[1]],
    height = size[[2]],
    brush = brush,
    params = params
  )
  
  htmlwidgets::createWidget(
    "pixels",
    x,
    width = size[[1]],
    height = size[[2]]
  )
}