#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)

# Define UI for application that draws a histogram
ui <- fluidPage(
   
   # Application title
   titlePanel("Predicting cars' stopping distance."),
   helpText("This application predicts cars' stopping distance (in feets) on basis of cars' speed. In order to obtain the predicted stopping distance, please adjust cars' speed below."),
   # Sidebar with a slider input for number of bins 
   sidebarLayout(
      sidebarPanel(
         sliderInput("bins",
                     "Speed of a car (in mph):",
                     min = 5,
                     max = 50,
                     value = 30)
      ),
      
      # Show a plot of the generated distribution
      mainPanel(
         textOutput("prediction")
      )
   )
)

# Define server logic required to draw a histogram
server <- function(input, output) {
   
   output$prediction <- renderText({
      data(cars)
      car_stopping_distance <- lm(cars$dist ~ cars$speed)
      # draw the histogram with the specified number of bins
      predicted_value = car_stopping_distance$coefficients[1] + car_stopping_distance$coefficients[2]*input$bins
      paste("Stopping distance value: ", predicted_value)
   })
}

# Run the application 
shinyApp(ui = ui, server = server)

