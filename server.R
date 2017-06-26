#
# This is the server logic of a Shiny web application. You can run the 
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)
library(UsingR)
data(galton)

# Define server logic required to draw a histogram
shinyServer(function(input, output) {
   
  output$distPlot <- renderPlot({
    
    # set variable based on input$bins from ui.R
    mu <- input$mu
    
    # set other variable to display over the plot
    mse <- mean((galton$child - mu)^2)
    isMin = c("")
    
    # draw the historam with the dynamic vertical line of population mean(mu)
    g <- ggplot(galton, aes(x = child)) + geom_histogram(fill = "salmon", colour = "black", binwidth = 1)
    g <- g + geom_vline(xintercept = mu, size = 3)
    # If user get the min MSE then display below
    if (round(mse,2) == round(var(galton$child),2))
        isMin = "That is Min MSE"
    g <- g + ggtitle(paste("mu = ", mu, ", MSE = ", round(mse,2), "  ", isMin, sep = ""))
    g
    
  })
  
})
