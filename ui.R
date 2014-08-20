library(shiny)

shinyUI(fluidPage(
    titlePanel('The Memory Match Game'),
    
    sidebarLayout(
        sidebarPanel(
            conditionalPanel(
                'input.tab === "Game"',
                sliderInput('dif',
                            label = h3('Difficulty'),
                            min = 2,
                            max = 9,
                            value = 3
                ),
                
                actionButton("init", "Start!")
            ),
            conditionalPanel(
                'input.tab === "Table"',
                'Table'
            ),
            conditionalPanel(
                'input.tab === "Plot"',
                'Plot'
            )
        ),
        
        mainPanel(
            tabsetPanel(
                id = 'tab',
                tabPanel('Game', 
                         h3(textOutput('turns')),
                         h3(textOutput('msg')),
                         uiOutput('numbers')),
                tabPanel('Table', 
                         dataTableOutput('table')),
                tabPanel('Plot', 
                         plotOutput('plot'))
            )
            
        )
    )
))
