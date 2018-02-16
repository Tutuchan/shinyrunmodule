#' run a module in standalone mode
#'
#' @param module_name a character, the name of the **server** function
#' @param ... additional named parameters passed to the module
#' @param use_shiny_dashboard a logical, set to TRUE if the module uses *shinydashboard* components
#'
#' @importFrom shiny runApp
#' @export
run_module <- function(module_name, ..., use_shiny_dashboard = FALSE) {

  mc   <- match.call()
  dots <- build_params(mc)

  # calls
  ui_name     <- find_ui_name(module_name)
  ui_call     <- build_ui_call(ui_name, dots)
  server_call <- build_server_call(module_name, dots)

  # app
  app <- build_app(module_name, ui_call, server_call, use_shiny_dashboard)

  runApp(appDir = app)

}
