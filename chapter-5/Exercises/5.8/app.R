library(shiny)

injuries <- vroom::vroom("injuries.tsv.gz")
products <- vroom::vroom("products.tsv")
population <- vroom::vroom("population.tsv")

count_top <- function(df, var, n = 5) {
  df %>%
    mutate({{ var }} := fct_lump(fct_infreq({{ var }}), n = n)) %>%
    group_by({{ var }}) %>%
    summarise(n = as.integer(sum(weight)))
}

ui <- fluidPage(
  h1("Problem 1"),
  img(src = "mastering-shiny-5.8-p1.png", width = "100%"),
  br(),

  h1("Problem 2"),
  p("If you flip `fct_infreq()` and `fct_lump()`, you lump *first*, thereby lumping all but the five
    most frequent variables into an 'Other' category: so, when you sort the factors by `fct_infreq`, 'Other' 
    is counted as a proper factor to be ordered by. So, in this case we want to order _first_, and then lump
    by frequency."),
  br(),

  h1("Full Application, for Problems 3-4"),
  fluidRow(
    column(
      6,
      selectInput("code", "Product",
        choices = setNames(products$prod_code, products$title),
        width = "100%"
      )
    ),
    column(2, selectInput("y", "Y axis", c("rate", "count"), width = "100%")),
    column(3, numericInput("nrow", "Rows in summary", value = 5, step = 1))
  ),
  fluidRow(
    column(4, tableOutput("diag")),
    column(4, tableOutput("body_part")),
    column(4, tableOutput("location"))
  ),
  fluidRow(
    column(12, plotOutput("age_sex"))
  ),
  fluidRow(
    column(2, actionButton("previous_story", "Previous Story", width = "100%")),
    column(2, actionButton("next_story", "Next Story", width = "100%"))
  ),
  br(),
  fluidRow(
    column(12, textOutput("narrative"))
  ),
  br()
)

server <- function(input, output, session) {
  selected <- reactive(injuries %>% filter(prod_code == input$code))

  output$diag <- renderTable(
    count_top(selected(), diag, input$nrow),
    width = "100%"
  )
  output$body_part <- renderTable(
    count_top(selected(), body_part, input$nrow),
    width = "100%"
  )
  output$location <- renderTable(
    count_top(selected(), location, input$nrow),
    width = "100%"
  )

  summary <- reactive({
    selected() %>%
      count(age, sex, wt = weight) %>%
      left_join(population, by = c("age", "sex")) %>%
      mutate(rate = n / population * 1e4)
  })

  output$age_sex <- renderPlot(
    {
      if (input$y == "count") {
        summary() %>%
          ggplot(aes(age, n, colour = sex)) +
          geom_line() +
          labs(y = "Estimated number of injuries")
      } else {
        summary() %>%
          ggplot(aes(age, rate, colour = sex)) +
          geom_line(na.rm = TRUE) +
          labs(y = "Injuries per 10,000 people")
      }
    },
    res = 96
  )

  values <- reactiveValues(istory = 1)

  observeEvent(input$previous_story, {
    if (values$istory == 1) {
      values$istory <- nrow(selected())
    } else {
      values$istory <- values$istory - 1
    }
  })

  observeEvent(input$next_story, {
    if (values$istory >= nrow(selected())) {
      values$istory <- 1
    } else {
      values$istory <- values$istory + 1
    }
  })

  output$narrative <- renderText({
    input$story
    narratives <- selected() %>% pull(narrative)
    num_narratives <- narratives %>% length()
    narratives %>% nth(values$istory %% (num_narratives + 1))
  })
}

shinyApp(ui, server)
