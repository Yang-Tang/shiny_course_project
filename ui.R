library(shiny)

shinyUI(fluidPage(
    titlePanel('The Shiny Memory Match Game'),
    
    sidebarLayout(
        sidebarPanel(
            conditionalPanel(
                'input.tab === "Game"',
                h3('Introduction'),
                includeText("intro.txt"),
                h3('Difficulty'),
                sliderInput('dif',
                            label = 'Choose difficulty level of the game',
                            min = 2,
                            max = 9,
                            value = 3
                ),
                br(),
                actionButton("init", "Restart!"),
                br(),
                br(),
                em('Please note that, for some unknown reason, there are some lags when this app runs on the ShinyApps.io server. While the widget reacting to your click, please be patient .'),
                h3('Demo'),
                img(src="pic.gif", height = 518, width = 409)
            ),
            conditionalPanel(
                'input.tab === "Table"',
                h3('The Game Records'),
                p('This table is the historical records of games ever played, including the difficulty users choosed and the turns of guesses they used.'),
                p('To view the data, the users have to ',strong('fininsh at least one game. :)'))
            ),
            conditionalPanel(
                'input.tab === "Plot"',
                h3('The Plot of Game Records'),
                p('This figure shows the relationship between the difficulty users selected and the turns of guessese they used to finish that game.'),
                p('To view the plot, the users have to ',strong('fininsh at least one game. :)'))
            )
        ),
        
        mainPanel(
            tabsetPanel(
                id = 'tab',
                tabPanel('Game',
                         h3(textOutput('turns')),
                         uiOutput('numbers'),
                         h4(textOutput('msg'))   
                ),         
                tabPanel('Table', 
                         dataTableOutput('table')),
                tabPanel('Plot', 
                         plotOutput('plot'))
            )
            
        )
    )
))
