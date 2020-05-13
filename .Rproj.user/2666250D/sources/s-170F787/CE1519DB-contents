library(shiny)

ui <- fluidPage(
  theme = shinythemes::shinytheme("paper"),
  headerPanel("Central limit theorem"),
  fluidRow(
    column(
      8,
      plotOutput("hist")
    ),
    column(
      4,
      numericInput("m", "Number of samples:", 2, min = 1, max = 100)
    )
  )
)

server <- function(input, output, session) {
  output$hist <- renderPlot(
    {
      means <- replicate(1e4, mean(runif(input$m)))
      hist(means, breaks = 20)
    },
    res = 96
  )
}

shinyApp(ui, server)
