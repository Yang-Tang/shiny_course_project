The Shiny Memory Match Game
========================================================
author: Yang
date: 2014-08-21

Intruduction
========================================================

Picture matching game is a very famous memory challenge game that player click on the different cards to find pairs of matching pictures. 

In this simple [Shiny deploy of matching game](http://doubletang.shinyapps.io/shiny_course_project/), I use digits (from 1 to 9) instead of pictures. The mission for player is trying to uncover all the pairs of digits using as few guesses as possible. 

App Structure
========================================================

This Shiny App contains three mainpages:
- [Game](#/game): The matching game interface 
- [Table](#/table_plot): The data records of games ever played
- [Plot](#/table_plot): The plot of game data

The source codes are hosted on [github](https://github.com/doubletang/shiny_course_project)

The Game Page
========================================================
id: game

In this game page, the users can play a matching game at differect levels of difficulties.

As shown below, random shuffled digits are masked as "X", when player click on them, the digits are showed temporarily. In each turn of guess, only two of the digits are allowed to be unmasked by click on.

- If the two digits are the same, they will be shown till the end of game. 
- If different, they will be masked again when the next turn of guess begins.

The player keeps on matching the digits until all the pairs of digits are discovered.

![alt text](Pitch-figure/pic.png)

The Table and Plot Page
========================================================
id: table_plot

The table and plot pages record the data of games ever played and show as a plot.


```
        Date Difficulty Turns_used
1 2014-08-20          2          1
2 2014-08-20          3          3
3 2014-08-20          4          5
4 2014-08-20          5          6
5 2014-08-20          6          8
6 2014-08-20          7         10
```

![plot of chunk unnamed-chunk-1](Pitch-figure/unnamed-chunk-1.png) 

