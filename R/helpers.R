#' build the list of parameters to run_module
#'
#' @param x the result of a [match.call()]
build_params <- function(x) {
  nx <- names(x)
  x  <- as.list(x)

  nx <- nx[!nx %in% c("", "module")]

  x[nx] %>%
    lapply(enquote)
}

#' find the name of the UI function
#'
#' @param name a character, the name of the server function
find_ui_name <- function(name) {
  suffixes <- c("UI", "Input", "Output")
  possibilities <- paste0(name, suffixes)
  existence <- lapply(possibilities, exists) %>%
    unlist()

  if (!any(existence)) stop("no module named '", name, "' found!")

  possibilities[existence]
}

#' build the call for the UI
#'
#' @param name a character, the name of the ui function
#' @param dots a list of parameters, as returned by [build_params()]
#'
#' @importFrom methods formalArgs
build_ui_call <- function(name, dots) {
  formals <- formalArgs(name)
  params  <- c(name = name, id = "id", dots[names(dots) %in% formals])

  do.call("call", params)
}

#' build the call for the server
#'
#' @param name a character, the name of the server function
#' @param dots a list of parameters, as returned by [build_params()]
#'
#' @importFrom shiny callModule
build_server_call <- function(name, dots) {
  formals <- methods::formalArgs(name)
  formals <- formals[!formals %in% c("input", "output", "session")]
  params  <- c(
    name = "callModule",
    module = enquote(as.symbol(name)),
    id = "id",
    dots[names(dots) %in% formals]
  )

  do.call("call", params)
}

#' build the app
#'
#' @param name a character, the name of the module
#' @param ui_call a call, as returned by [build_ui_call()]
#' @param server_call a call, as returned by [build_server_call()]
#' @param use_shiny_dashboard a logical, set to TRUE if the module uses *shinydashboard* components
#'
#' @importFrom shinydashboard dashboardPage dashboardHeader dashboardSidebar dashboardBody
#' @importFrom shiny fluidPage shinyApp
build_app <- function(name, ui_call, server_call, use_shiny_dashboard) {

  if (use_shiny_dashboard) {
    ui <- dashboardPage(
      header = dashboardHeader(title = name),
      sidebar = dashboardSidebar(),
      body = dashboardBody(eval(ui_call))
    )
  } else {
    ui <- fluidPage(
      title = name,
      eval(ui_call)
    )
  }

  server <- function(input, output, session) {
    eval(server_call)
  }

  shinyApp(ui = ui, server = server)
}
