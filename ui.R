library(shiny)

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
                               choices = ''
            ),
            h3(textOutput('msg')),
            uiOutput('numbers')
        )
    )
))
