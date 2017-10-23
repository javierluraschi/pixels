#' Show Pixels Widget
#' 
#' Creates an HTMLWidget to interact with pixels.
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
  size = c(500, 500),
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

  htmlwidgets::createWidget("pixels", x, width = size[[1]], height = size[[2]])
}

#' Shiny Widget Output
#' 
#' Provides a Shiny Widget for Output.
#' 
#' @param outputId The identifier for this widget.
#' @param width The width for this widget.
#' @param height The height for this widget.
#' 
shiny_pixels_output <- function(outputId, width = "100%", height = "400px") {
  shinyWidgetOutput(outputId, "pixels", width, height, package = "pixels")
}

#' Shiny Widget Render
#' 
#' Renders the Shiny Widget.
#' 
#' @param expr The \code{expr} for \code{shinyRenderWidget}.
#' @param env The \code{env} for \code{shinyRenderWidget}.
#' @param quoted The \code{quoted} for \code{shinyRenderWidget}.
#' 
#' @export
shiny_render_pixels <- function(expr, env = parent.frame(), quoted = FALSE) {
  if (!quoted) { expr <- substitute(expr) } # force quoted
  shinyRenderWidget(expr, shiny_pixels_output, env, quoted = TRUE)
}

#' Gets Pixels using a Shiny Gadget
#' 
#' Creates an ShinyGadget to retrieve pixels as a vector.
#' 
#' @param pixels The pixels to render as a 1-dimensional vector, row-first
#'   order expected.
#' @param grid The grid dimensions specified as a vector.
#' @param size The canvas dimensions specified as a vector.
#' @param brush The brush specified as a matrix.
#' @param params A set of parameters to customize the visual appearance.
#' 
#' @import shiny
#' @import miniUI
#' @export
get_pixels <- function(
  pixels = NULL,
  grid = c(28, 28),
  size = c(500, 500),
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
  
  ui <- miniPage(
    gadgetTitleBar("Pixels"),
    miniContentPanel(
      shiny_pixels_output("pixels")
    )
  )
  
  server <- function(input, output, session) {
    output$pixels <- shiny_render_pixels(
      show_pixels(pixels, grid, size, brush, params)
    )
    
    observeEvent(input$done, {
      returnValue <- input$pixels
      stopApp(returnValue)
    })
  }
  
  runGadget(ui, server)
}

