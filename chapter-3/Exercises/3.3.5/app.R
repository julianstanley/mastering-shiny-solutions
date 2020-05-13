library(shiny)

ui <- fluidPage(
    h1("Exercise 1"),
    plotOutput("plot", width = "700px", height = "300px"),
    tags$br(),
    
    h1("Exercise 2"),
    plotOutput("plot1", width = "50%"),
    plotOutput("plot2", width = "50%"),
    tags$br(),
    
    h1("Exercise 3"),
    dataTableOutput("table")
    
)

server <- function(input, output, session) {
    # Exercise 1
    output$plot <- renderPlot(plot(1:5), res = 96)
  
    # Exercise 2
    output$plot1 <- renderPlot(plot(1:5), res = 96)
    output$plot2 <- renderPlot(plot(5:1), res = 96)
  
    # Exercise 3
    output$table <- renderDataTable(mtcars, options = list(
        searching = FALSE,
        pageLength = 5))
}

shinyApp(ui, server)