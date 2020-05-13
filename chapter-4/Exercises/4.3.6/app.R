library(shiny)

ui <- fluidPage(
    h1("Problem 1"),
    tags$img(src = "reactive_graphs.png"),
    tags$br(),
    
    h1("Problem 2"),
    p("A reactive graph could contain a cycle, but it would lead to infinite recursion and a stack overflow."),
    p("For example, take this code:"),
    includeHTML("cyclical_graph.html"),
    
)

server <- function(input, output, session) {


}

shinyApp(ui, server)
