library(shiny)
library(shinyjs)

style <- ".float-right li:nth-child(2) { float: right;}"

ui <- fluidPage(
    useShinyjs(),
    tags$head(tags$style(HTML(style))),
    navbarPage(title = "Move Me",
               tabPanel("Nav Tab 1",
                        tabsetPanel(type = "tabs", id = "moveme",
                                    tabPanel(title = "Tab 1", 
                                             actionButton("move", "Move Tab2")),
                                    tabPanel(title = "Tab 2")
                        )
               ),
               tabPanel("Nav Tab 2")
    )
)

server <- function(input, output) {
    observeEvent(input$move, {
        toggleCssClass("moveme", "float-right")
    }, ignoreInit = TRUE)
}

shinyApp(ui, server)