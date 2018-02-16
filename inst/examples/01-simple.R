# From Shiny's faithful example: http://shiny.rstudio.com/gallery/faithful.html
library(shiny)

simpleModuleUI <- function(id) {

  ns <- NS(id)

  tagList(
    fluidRow(
      selectInput(inputId = ns("n_breaks"),
                  label = "Number of bins in histogram (approximate):",
                  choices = c(10, 20, 35, 50),
                  selected = 20),

      checkboxInput(inputId = ns("individual_obs"),
                    label = strong("Show individual observations"),
                    value = FALSE),

      checkboxInput(inputId = ns("density"),
                    label = strong("Show density estimate"),
                    value = FALSE),

      plotOutput(outputId = ns("main_plot"), height = "300px"),

      # Display this only if the density is shown
      conditionalPanel(condition = "input.density == true",
                       sliderInput(inputId = ns("bw_adjust"),
                                   label = "Bandwidth adjustment:",
                                   min = 0.2, max = 2, value = 1, step = 0.2),
                       ns = ns
      )
    )


  )
}

simpleModule <- function(input, output, session) {

  output$main_plot <- renderPlot({

    hist(faithful$eruptions,
         probability = TRUE,
         breaks = as.numeric(input$n_breaks),
         xlab = "Duration (minutes)",
         main = "Geyser eruption duration")

    if (input$individual_obs) {
      rug(faithful$eruptions)
    }

    if (input$density) {
      dens <- density(faithful$eruptions,
                      adjust = input$bw_adjust)
      lines(dens, col = "blue")
    }

  })
}
