  #' Launch myShinyApp,
  #' @export
  run_app <- function() {
    app_dir <- system.file('app', package = 'shinydeep')
    shiny::addResourcePath('www',system.file('www', package = 'shinydeep'))
    shiny::runApp(app_dir, display.mode = 'normal')
  }