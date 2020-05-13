library(shiny)

animals <-
    c("dog", "cat", "mouse", "bird", "other", "I hate animals")

ui <- fluidPage(
    h1("Inputs"),
    
    
    h2("Free text"),
    textInput("name", "What is your name?"),
    passwordInput("password", "What is your password?"),
    textAreaInput("story", "Tell me a story about yourself", rows = 2),
    tags$br(),
    
    h2("Numeric inputs"),
    numericInput(
        "num",
        "Number one",
        value = 0,
        min = 0,
        max = 100
    ),
    sliderInput(
        "num2",
        "Number two",
        value = 50,
        min = 0,
        max = 100
    ),
    sliderInput(
        "rng",
        "Range",
        value = c(10, 20),
        min = 0,
        max = 100
    ),
    tags$br(),
    
    h2("Dates"),
    dateInput("dob", "When where you born?"),
    dateRangeInput("holiday", "When do you want to go on vacation next year?"),
    tags$br(),
    
    h2("Limited choices"),
    selectInput("state", "What's your favorite state?", state.name, multiple = TRUE),
    radioButtons("animal", "What's your favorite animal?", animals),
    radioButtons(
        "rb",
        "Choose one:",
        choiceNames = list(icon("angry"),
                           icon("smile"),
                           icon("sad-tear")),
        choiceValues = list("angry", "happy", "sad")
    ),
    checkboxGroupInput("animal", "What animals do you like?", animals),
    checkboxInput("cleanup", "Clean up?", value = TRUE),
    checkboxInput("shutdown", "Shutdown?"),
    tags$br(),
    
    h2("File uploads"),
    fileInput("upload", NULL),
    tags$br(),
    
    h2("Action buttons"),
    actionButton("click", "Click me!"),
    actionButton("drink", "Drink me!", icon = icon("coffee")),
    
    
    h1("Outputs"),
    
    
    h2("Text"),
    textOutput("text"),
    verbatimTextOutput("code"),
    tags$br(),
    
    h2("Tables"),
    tableOutput("static"),
    dataTableOutput("dynamic"),
    tags$br(),
    
    h2("Plots"),
    plotOutput("plot", width = "400px"),
    p("These plots actually can have some built-in interactivity!"),
    tags$br(),
    
    h2("Downloads"),
    p("These are a thing, but we'll come back to it later"),
    br(),
    
    
    h1("Layouts"),
    
    
    titlePanel("Hello Shiny!"),
    sidebarLayout(
        sidebarPanel(
            numericInput("m", "Number of samples:", 2, min = 1, max = 1000, step = 50)
        ),
        mainPanel(
            plotOutput("hist")
        )
    )
    
    
)

server <- function(input, output, session) {
    # Outputs
    
    ## Text
    output$text <- renderText("Hello friend!")
    output$code <- renderPrint(summary(1:10))
    
    ## Tables
    output$static <- renderTable(head(mtcars))
    output$dynamic <- renderDataTable(mtcars, options = list(pageLength = 5))
    
    ## Plots
    output$plot <- renderPlot(plot(1:5), res = 96)
    
    # Layouts
    output$hist <- renderPlot({
        means <- replicate(1e4, mean(runif(input$m)))
        hist(means, breaks = 20)
    }, res = 96)
    
}

shinyApp(ui, server)