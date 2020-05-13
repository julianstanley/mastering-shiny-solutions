library(shiny)

ui <- fluidPage(
    h1("Exercise 1"),
    textInput("name", label = "", placeholder = "Your name"),
    tags$br(),
    h1("Exercise 2"),
    sliderInput("delivery", "When should we deliver?", min = as.Date("2019-08-09"), 
                max = as.Date("2019-08-16"), 
                value = as.Date("2019-08-10")),
    tags$br(),
    h1("Exercise 3"),
    selectInput("animals", "Choose some animals", choices = list(
        "Cats" = c("Lion", "Tiger", "Cheetah"),
        "Not Cats" = c("Wolf", "Dog", "Whale"),
        "Reptiles?" = c("Dragon", "Lizard", "Loch Ness Monster")
    )),
    tags$br(),
    h1("Exercise 4"),
    sliderInput("anim", "", min = 0, max = 100, step = 5, value = 0,
                animate = animationOptions(interval = 100)),
    tags$br(),
    h1("Exercise 5"),
    numericInput("number", "Select a value", value = 150, min = 0, max = 1000, step = 50),
    p("In this case, the 'step' argument is used as the step for the arrows on the right hand 
      side of the numericInput box.")
)

server <- function(input, output, session) {
  
}

shinyApp(ui, server)