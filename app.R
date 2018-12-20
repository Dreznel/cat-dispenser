#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(httr)
library(imager)

# Define UI for application
ui <- fluidPage(
   
   # Application title
   titlePanel("Cat Dispenser"),
   
   sidebarLayout(
      sidebarPanel(
        actionButton("catButton", "New Kitty!")
      ), 
      
      mainPanel(
         imageOutput("catPic")
      )
   )
)

server <- function(input, output) {
   
   output$catPic <- renderImage({
     input$catButton
     
     response1 <- GET("https://api.thecatapi.com/v1/images/search?mime_types=png")
     catUrl <- content(response1)[[1]]$url
     download.file(catUrl, 'currentPicture.PNG', mode = 'wb')
     # response2 <- GET(catUrl)
     # imageData <- content(response2)
     # catPicture <- load.image('currentPicture.PNG')
     # catPicture <- load.image('tiger.jpg')
     # catPicture
     
     list(src = 'currentPicture.PNG',
          contentType = 'image/png',
          alt = 'This is alternate text.'
          )
   }, deleteFile = TRUE)
}

# Run the application 
shinyApp(ui = ui, server = server)

