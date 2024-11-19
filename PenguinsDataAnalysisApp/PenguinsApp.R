library(shiny)
library(palmerpenguins)
library(tidyverse)


# Define UI for application which returns user defined data for the Palmerpenguins data set
ui <- fluidPage(


    titlePanel("Penguins data near Palmer Station in Antartica Application"), # title of application

    # Sidebar with a slider input for the weight of the penguins
    sidebarLayout(
        sidebarPanel(
            sliderInput("massInput","Mass of penguins",2500, 6500, c(3500, 5000), post = "g"), # range and default selection

    ### FEATURE 1:  Allows for the user to search multiple entries simultaneously ###
    # This feature is useful to compare penguins by species and to select individual islands

      # The user can choose which penguin species to select
            checkboxGroupInput("speciesInput", "Select penguin species:",
                         choices = c("Adelie", "Gentoo", "Chinstrap"),
                         selected = c("Adelie")), # c() is used to allow for multiple selections

     # The user can choose which island to select
            checkboxGroupInput("islandInput", "Select island of interest:",
                               choices = c("Torgersen","Biscoe","Dream"),
                               selected = c("Dream")), # c() is used to allow for multiple selections

        ),

        # Show a body mass histogram and table with the filtered results
        mainPanel(

    ### FEATURE 2 and 3: Display the plot and table in separate tabs, and display count after filtering ###
    # Feature 2 allows the data to be presented in a less condensed manner and make the UI more user friendly
    # Feature 3 shows how many results are displayed after filtering providing the user with insight about the remaining sample size

          tabsetPanel(
            # Tab for displaying the plot (FEATURE 2)
            tabPanel("Penguin mass plot",
                     plotOutput("coolplot"),
                     br(), br(),

                     # displays the number of counts after filtering (FEATURE 3)
                     textOutput("plotCount")
            ),

            # Tab for displaying the table (FEATURE 2)
            tabPanel("Penguins fitered data",

    ### FEATURE 4: Makes result table interactive
    # This feature is useful for sorting variables, searching the data by keywords, and overall enhances the friendliness of the UI

                     DT::dataTableOutput("results"), # interactive table (FEATURE 4)
                     br(), br(),

                     # displays the number of counts after filtering (FEATURE 3)
                     textOutput("tableCount")
            )
          )
        )
    )
)

# Define server logic required to display output
server <- function(input, output) {

  filtered <- reactive({ # reactive output based on changing input

    # Checks for user input
    if (is.null(input$islandInput) || is.null(input$speciesInput)) { # display empty space if no input is selected
      return()
    }

    # Filter data per input
    data <- penguins %>%
      filter(body_mass_g >= input$massInput[1], # lower range of body mass
             body_mass_g <= input$massInput[2], # upper range of body mass
             species %in% input$speciesInput, # choose multiple inputs (FEATURE 1)
             island %in% input$islandInput) %>% # choose multiple inputs (FEATURE 1)
      select(species, island, sex, body_mass_g, everything()) # rearrange output columns

  })

  # Count the output and display it for the figure tab (FEATURE 3)
  output$plotCount <- renderText({
    data <- filtered()
    if (is.null(data) || nrow(data) == 0) {
      return("No results found.. Try changing the input!")
    }
    paste(nrow(data)," results were found!")
  })

  # Count the output and display it for the table tab (FEATURE 3)
  output$tableCount <- renderText({
    data <- filtered()
    if (is.null(data) || nrow(data) == 0) {
      return("No results found.. Try changing the input!")
    }
    paste(nrow(data)," results were found!")
  })

  # Generate plot using ggplot
  output$coolplot <- renderPlot({
    if (is.null(filtered())) { # displays empty space if no data is available for generating the figure
      return()
    }
    ggplot(filtered(), aes(body_mass_g,fill=species)) +
      geom_histogram(binwidth = 100, alpha = 0.4, colour="black", position="identity") +
      labs(x="Body mass [g]",y="Number of counts",fill="Species")+
      theme_bw()
  })

  # Return the filtered data
  output$results <- DT::renderDataTable({ # interactive table (FEATURE 4)
    filtered()
  })
}

# Run the application
shinyApp(ui, server)
