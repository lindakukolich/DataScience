
# This is the user-interface definition of a Shiny web application.
# You can find out more about building applications with Shiny here:
#
# http://shiny.rstudio.com
#

library(shiny)

shinyUI(fluidPage(

    # Application title
    titlePanel("Examining Two Datasets"),

    sidebarLayout(
        sidebarPanel(
            tags$div(class="header",
                     tags$p("Select data to plot")),
            selectInput("data", "Data", c(gauss="Gauss", iris="Iris"), selected="Gauss"),
            conditionalPanel(
                condition = "input.data == 'Gauss'",
                tags$p("Generate samples of Gaussian data. You can change the position of each distribution, as well as its variance."),
                tags$p("The plot will show the generated data, the two centers, and an ellipse showing the standard deviation of the generated data"),
                helpText("Use sliders to set the centers and variances of two 2-dimensional Gaussians"),
                fluidRow(
                    column(6,
                           tags$p("Gaussian 1"),
                           sliderInput("x1", "center: x", min=-2, max=2, value=-1),
                           sliderInput("y1", "center: y", min=-2, max=2, value=-1),
                           sliderInput("sd1", "standard deviation", min=.1, max=2, value=1)
                    ),
                    column(6,
                           tags$p("Gaussian 2"),
                           sliderInput("x2", "center: x", min=-2, max=2, value=1),
                           sliderInput("y2", "center: y", min=-2, max=2, value=1),
                           sliderInput("sd2", "standard deviation", min=.1, max=2, value=1)
                    )
                )
            ),
            conditionalPanel(
                condition = "input.data == 'Iris'",
                tags$p("Some Species of the flower Iris can be identified using the size of their petals, and the size of the sepals. The sepals are the leaf-like outer parts of a flower that enclose the bud while it develops."),
                tags$p("In this data set, measurements have been made of the petal and sepal sizes of different flowers from three species of iris."),
                tags$p("The plot will display two of the four variables, allowing you to explore which measurements are most helpful in distinguishing these three species"),
                helpText("Select two variables to plot"),
                selectInput("dim1", "Dimension 1",
                            c("Sepal.Length",
                              "Sepal.Width",
                              "Petal.Length",
                              "Petal.Width"), selected="Sepal.Length"),
                selectInput("dim2", "Dimension 2",
                            c("Sepal.Length",
                              "Sepal.Width",
                              "Petal.Length",
                              "Petal.Width"), selected="Sepal.Width")
            )
        ),

        # Show a plot of the generated distribution
        mainPanel(
            plotOutput("distPlot")
        )
    )
))
