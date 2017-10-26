#' Shiny Widget Output
#' 
#' Provides a Shiny Widget for Output.
#' 
#' @param outputId The identifier for this widget.
#' @param width The width for this widget.
#' @param height The height for this widget.
#' 
#' @examples 
#' library(shiny)
#' 
#' ui <- fluidPage(
#'   tags$head(
#'     tags$style(HTML("
#'       #pixels {
#'         height: 270px !important;
#'         margin-top: 10px;
#'       }
#'     "))
#'   ),
#'   titlePanel("Digit Capture Application"),
#'   textOutput("prompt"),
#'   shiny_pixels_output("pixels"),
#'   actionButton("captureDigit", "Capture")
#' )
#' 
#' server <- function(input, output) {
#'   output$pixels <- shiny_render_pixels(
#'     show_pixels()
#'   )
#' 
#'   digit <- reactiveVal(floor(runif(1, 1, 10)))
#'   output$prompt <- renderText(paste0("Please draw number ", digit(), ":"))
#'
#'   observeEvent(input$captureDigit, {
#'     digit_path <- file.path("digits", digit())
#'     if (!dir.exists(digit_path)) dir.create(digit_path, recursive = TRUE)
#'     saveRDS(input$pixels, paste0(digit_path, "/", as.numeric(Sys.time()), ".rds"))
#'  
#'     digit(floor(runif(1, 1, 10)))
#'     output$pixels <- shiny_render_pixels(
#'       show_pixels()
#'     )
#'   })
#' }
#' 
#' if (interactive()) {
#'   shinyApp(ui = ui, server = server)
#' }
#' 
#' @export
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
#' @seealso [shiny_pixels_output()] for an example of using this function
#' within a 'Shiny' application.
#'   
#' @export
shiny_render_pixels <- function(expr, env = parent.frame(), quoted = FALSE) {
  if (!quoted) { expr <- substitute(expr) } # force quoted
  shinyRenderWidget(expr, shiny_pixels_output, env, quoted = TRUE)
}