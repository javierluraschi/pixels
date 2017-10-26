#' Gets Pixels
#' 
#' Creates an ShinyGadget to retrieve pixels.
#' 
#' @param pixels The pixels to render as a 1-dimensional vector, row-first
#'   order expected.
#' @param grid The grid dimensions specified as a vector.
#' @param size The canvas dimensions specified as a vector.
#' @param brush The brush specified as a matrix.
#' @param params A set of parameters to customize the visual appearance.
#' 
#' #' @examples 
#' 
#' library(pixels)
#' if (interactive()) {
#'   get_pixels()
#' }
#' 
#' @import shiny
#' @import miniUI
#' @export
get_pixels <- function(
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