
# This is the server logic for a Shiny web application.
# You can find out more about building applications with Shiny here:
#
# http://shiny.rstudio.com
#

library(shiny)
library(ggplot2)

generateGauss <- function(input) {
    n <- 200
    x1 = rnorm(n, input$x1, input$sd1)
    y1 = rnorm(n, input$y1, input$sd1)
    x2 = rnorm(n, input$x2, input$sd2)
    y2 = rnorm(n, input$y2, input$sd2)
    labels <- factor(c(rep(0, n), rep(1, n)))
    df <- data.frame(lab=labels, x=c(x1, x2), y=c(y1, y2))
    dfText <- data.frame(lab=c(0, 1), x=c(input$x1, input$x2), y=c(input$y1, input$y2))
    list(df, dfText)
}

shinyServer(function(input, output) {
    output$distPlot <- renderPlot({
        if (input$data == "Gauss") {
            df <- generateGauss(input)
            g <- ggplot(df[[1]], aes(x, y, xmin=-6, xmax = 6, ymin = -6, ymax = 6))
            g <- g + ggtitle("Generated Gaussian Data")
            g <- g + geom_point(aes(colour = lab))
            g <- g + stat_ellipse(data=subset(df[[1]], df[[1]]$lab==0))
            g <- g + stat_ellipse(data=subset(df[[1]], df[[1]]$lab==1))
            g <- g + geom_point(data=df[[2]])
            g
        } else {
            g <- ggplot(iris, aes_string(input$dim1, input$dim2))
            g <- g + ggtitle("Measurements from Iris Species")
            g <- g + geom_point(aes(colour = Species))
            g
        }
    })
})
