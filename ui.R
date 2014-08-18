library(shiny)
n = 6
nums <- sample(rep(c(1:(n/2)), times=2), n, F)
guessed <- show <- rep(F, times=n)
lst <- as.list(c(1:n))
names(lst) <- rep('X', times=n)
num1 <- num2 <- -1
idx <- 1
shinyUI(fluidPage(
    titlePanel('The Memory Match Game'),
    
    sidebarLayout(
        sidebarPanel(
            sliderInput('dif',
                        label = h3('Difficulty'),
                        min = 2,
                        max = 9,
                        value = 3
            ),
            
            actionButton("init", "Start!")
        ),
        mainPanel(
            checkboxGroupInput('numbers',
                               label = h3('Numbers'),
                               choices = lst
            ),
            h3(textOutput('msg'))
        )
    )
))
