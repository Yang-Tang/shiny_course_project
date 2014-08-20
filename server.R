library(shiny)
n <- 6
nums <- sample(rep(c(1:(n/2)), times=2), n, F)
guessed <- show <- rep(F, times=n)
lst <- as.list(c(1:n))
names(lst) <- rep('X', times=n)
num1 <- num2 <- -1
idx <- 1
exposed <- c(F,F,F,F,F,T)

shinyServer(function(input, output, session){
    output$numbers <- renderUI({
#         input$init
#         input$dif
        for(i in c(1:n)){
            if(i %in% as.numeric(input$numbers2)){
                names(lst)[i] <<- as.character(nums[i])
            } else {
                names(lst)[i] <<- 'X'
            }
        }
        checkboxGroupInput('numbers2',
                           label = 'num2',
                           choices = lst,
                           selected = input$numbers2)
    })
    observe({
        input$init
        n <<- 2* as.numeric(input$dif)
        nums <<- sample(rep(c(1:(n/2)), times=2), n, F)
        guessed <<- show <<- rep(F, times=n)
        lst <<- as.list(c(1:n))
        names(lst) <<- rep('X', times=n)
        isolate({updateCheckboxGroupInput(session, 'numbers', choices = lst, selected=NULL)})
        output$msg <- renderText({''})
        
    })
    
    observe({
        if(length(input$numbers) == 1){
            idx <<- c(as.numeric(input$numbers[1]))
            num1 <<- nums[idx[1]]
            show[idx[1]] <<- T
            names(lst)[idx[1]] <<- as.character(num1)
        } else if(length(input$numbers) == 2){
            for(sel in input$numbers){
                if (!(as.numeric(sel) %in% idx)) {
                    idx <<- c(idx, as.numeric(sel))
                }
            }
            num2 <<- nums[idx[2]]
            show[idx[2]] <<- T
            names(lst)[idx[2]] <<- as.character(num2)
            if (num1 == num2) {
                guessed[idx[1]] <<- guessed[idx[2]] <<- T
            }
        } else if(length(input$numbers) == 3){
            for(sel in input$numbers){
                if (!(as.numeric(sel) %in% idx)) {
                    idx <<- c(as.numeric(sel))
                    break
                }
            }
            num1 <<- nums[idx[1]]
            num2 <<- -1
            show <<- guessed
            show[idx[1]] <<- T
            for(i in c(1:n)){
                if(!show[i]){
                    names(lst)[i] <<- 'X'
                }
            }
        } else if(length(input$numbers) == 0){
            
            for(i in c(1:n)){
                if(!guessed[i]){
                    names(lst)[i] <<- 'X'
                }
            }
            idx <<- NULL
            num1 <<- num2 <<- -1
        }
        isolate({
            updateCheckboxGroupInput(session, 'numbers', 
                                     choices = lst, 
                                     selected=as.character(idx)
            )
        })
        if(!(F %in% guessed)){
            output$msg <- renderText({'Good job! Once more?'})
        }
    })
})
