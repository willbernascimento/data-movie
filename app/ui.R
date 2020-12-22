library(shiny)
library(plotly)
library(dplyr)


ui <- fluidPage(
  
  titlePanel("Data Movie Analytics"),
  
  sidebarLayout(
    
    sidebarPanel(
      tags$div(tags$h2("Metascore"),
               
               tags$p("Acording to IMDb is a rating score of a movie. Several cinema critics in the world evaluate the film and IMDb takes a weighted average of these evaluations. The higher the metascore, the more positive ratings a film has."),
               tags$a(href="https://www.imdb.com/list/ls051211184/", "Take a look on IMDb!"),
               tags$p("In the histogram you can see the distribution of the grades of the films evaluated since the 2000s. The metascore is on the x axis and it goes from 0 to 100. the y axis represents the number of films evaluated in that metascore. You can mouse over to see the metascore and the frequency of films in that category. Typically, most films receive a metascore between 40 and 70.")
      ),
      
      sliderInput("obs", "Selec the movies year:",
                  min=2000,
                  max = 2020,
                  value = 2001,
                  sep = "",
                  step = 1),
      
      tags$div(
        
        tags$p("In the line graph we can see the boxplot and the average of the metascore over time (the blue line). You can use the mouse to view information one at a time. Click Line mean or boxplot in the legend to see just one option. The chart will help you evaluate the grade (metascore) of a film in more specific years.")
      )
  ),
  

  
  
  mainPanel(
    
    plotlyOutput("distPlot"),
    
    
    
    plotlyOutput("linePlot")
    
    
    )
  )
)

