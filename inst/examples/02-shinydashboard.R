# From shinydashboard's documentation: https://rstudio.github.io/shinydashboard/get_started.html
library(shiny)
library(shinydashboard)
shinyDashboardModuleUI <- function(id) {

  ns <- NS(id)

  tagList(
    fluidRow(
        box(plotOutput(ns("plot1"), height = 250)),

        box(
          title = "Controls",
          sliderInput(ns("slider"), "Number of observations:", 1, 100, 50)
        )
    )
  )
}

shinyDashboardModule <- function(input, output, session) {

  set.seed(122)
  histdata <- rnorm(500)

  output$plot1 <- renderPlot({
    data <- histdata[seq_len(input$slider)]
    hist(data)
  })

}
