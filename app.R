library(shiny)
library(datasets)
library(ggplot2)


mpgData <- mtcars
mpgData$am <- factor(mpgData$am, labels = c("Automatic", "Manual"))



ui <- fluidPage(
  
  
  titlePanel("Miles Per Gallon"),
  
 
  sidebarLayout(
    
   
    sidebarPanel(
      
      
      selectInput("variable", "Variable:",
                  c("Cylinders" = "cyl",
                    "Transmission" = "am",
                    "Gears" = "gear")),
      
     
    
      
    ),
    
   
    mainPanel(
      
      
      h3(textOutput("caption")),
      
     
      plotOutput("mpgPlot")
      
    )
  )
)


server <- function(input, output) {
  

  formulaText <- reactive({
    paste("mpg ~", input$variable)
  })
  

  output$caption <- renderText({
    formulaText()
  })
  
 
  output$mpgPlot <- renderPlot({
    
##  if (selectInput = "cyl") {     I couldn't find how to link the selections to the charts
    
    ggplot(data=mtcars, mapping=aes(mpg)) + facet_wrap(~ cyl, nrow = 3) + geom_histogram(binwidth=5,col = "white", fill= "#75AADB",width= 10)
#  }
     
   # if (selectInput("am")){
    
    ggplot(data=mtcars, mapping=aes(mpg)) + facet_wrap(~ am, nrow = 2) + geom_histogram(binwidth=5,col = "white", fill= "#75AADB",width= 10)
#  }
    
    ggplot(data=mtcars, mapping=aes(mpg)) + facet_wrap(~ gear, nrow = 3) + geom_histogram(binwidth=5,col = "white", fill= "#75AADB",width= 10)
    
  })
  
}

shinyApp(ui, server)