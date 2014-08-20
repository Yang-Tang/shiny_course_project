library(shiny)
library(ggplot2)
n <- 6
nums <- sample(rep(c(1:(n/2)), times=2), n, F)
guessed <- rep(F, times=n)
lst <- as.list(c(1:n))
names(lst) <- rep('X', times=n)
num1 <- num2 <- -1
selected <- c()
game_finished <- F
data <- readRDS('data/data.rds')

shinyServer(function(input, output, session){
    output$numbers <- renderUI({
        if(length(input$numbers) == 1){
            sel <<- as.numeric(input$numbers)
            if(!guessed[sel]){
                guessed[sel] <<- T
                num1 <<- names(lst)[sel] <<- as.character(nums[sel])
                selected <<- input$numbers
            }
        } else if(length(input$numbers) == 2){
            if(input$numbers[1] == selected[1]){
                sel <<- as.numeric(input$numbers[2])
            } else {
                sel <<- as.numeric(input$numbers[1])
            }
            if(!guessed[sel]){
                guessed[sel] <<- T
                num2 <<- names(lst)[sel] <<- as.character(nums[sel])
                selected <<- input$numbers
            }
        } else if(length(input$numbers) == 3){
            if(!(num1 == num2)){
                names(lst)[as.numeric(selected)] <<- 'X'
                guessed[as.numeric(selected)] <<- F
            }
            if(!game_finished){
                turns <<- turns + 1
            }
            for(idx in input$numbers){
                if(!(idx %in% selected)){
                    sel <<- as.numeric(idx)
                    break
                }
            }
            if(!guessed[sel]){
                guessed[sel] <<- T
                num1 <<- names(lst)[sel] <<- as.character(nums[sel])
                selected <<- as.character(sel)
            } else {
                selected <<- c()
            }
        }
        if(!(F %in% guessed) & !game_finished){
            newrecord <<- data.frame('Date'=Sys.Date(),
                             'Difficulty'=n/2, 
                             'Turns_used'=turns, 
                             stringsAsFactors=FALSE)
            data <<- rbind(data, newrecord)
            print(data)
            saveRDS(data, 'data/data.rds')
            game_finished <<- T
            output$msg <- renderText({'Good job! Click the Restart button to play once more.'})
            output$table <- renderDataTable({data})
            output$plot <- renderPlot({
                ggplot(data, aes(x=Difficulty, y=Turns_used, colour=Difficulty)) +
                    geom_point(size=5, 
                               alpha=0.5,
                               position="jitter")
            })
        }
        output$turns <- renderText({
            paste('Turns of guessed used: ', as.character(turns))
        })
        checkboxGroupInput('numbers',
                           label = 'Match digits by click two of "X" below',
                           choices = lst,
                           selected = selected)
    })
    observe({
        input$init
        turns <<- 0
        n <<- 2* as.numeric(input$dif)
        nums <<- sample(rep(c(1:(n/2)), times=2), n, F)
        guessed <<- rep(F, times=n)
        selected <<- c()
        lst <<- as.list(c(1:n))
        names(lst) <<- rep('X', times=n)
        isolate({updateCheckboxGroupInput(session, 'numbers', choices = lst, selected=NULL)})
        output$msg <- renderText({''})
        game_finished <<- F
        
    })
})
