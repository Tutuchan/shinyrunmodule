run_example <- function(example = NULL, ...) {

  if (is.null(example)) {
    warning("Pick an example: ", paste(examples_list(), collapse = ", "))
    return(invisible(NULL))
  }

  if (!example %in% examples_list()) {
    stop("example must be one of ", paste(examples_list(), collapse = ", "))
  }

  file_name <- switch(
    example,
    simple         = "01-simple.R",
    shinydashboard = "02-shinydashboard.R",
    params         = "03-params.R"
  )

  f <- system.file(file.path("examples", file_name), package = "shinyrunmodule")
  source(f)

  switch(
    example,
    simple         = {
      run_module("simpleModule")
    },
    shinydashboard = {
      run_module("shinyDashboardModule", use_shiny_dashboard = TRUE)
    },
    params         = {
      run_module("csvFile", ...)
    }
  )

}

examples_list <- function() {
  c("simple", "shinydashboard", "params")
}
