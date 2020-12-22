library(shiny)
library(plotly)
library(ggplot2)
library(dplyr)

movies <- readRDS('movies_2000.rds')

movies_metascore <- movies[!is.na(movies$metascore) & 
                             movies$year %in% seq(2000, 2020), ]


metascore.variacao <-
  movies_metascore %>%
  filter(year %in% seq(2000, 2020)) %>%
  group_by(year) %>%
  summarise(metascore.mean = mean(metascore))


movies_metascore <- movies_metascore %>% 
  ungroup()

movies_metascore$year <- as.character(movies_metascore$year)



server <- function(input, output, session) {
  theData = reactive({
    
    out <- 
      movies_metascore %>%
      filter(year == input$obs)
    
    return(out)
  })
  
  
  output$summary = renderText({
    
  theData()$year; 
    theData()$metascore
    
  })
  
  
  output$distPlot <- renderPlotly({
    plot_ly(
      theData(),
      x = ~ metascore, 
      type = "histogram"
    ) %>% layout(title= "Metascore distribution")
  })
  
  output$linePlot <- renderPlotly({
    plot_ly(
      metascore.variacao,
      name='Line mean',
      x = ~ year,
      y = ~ metascore.mean,
      type = 'scatter',
      mode = 'lines'
    ) %>% 
      add_boxplot(
        name = 'Boxplot',
        x = ~ year,
        y = ~ metascore, 
        data = movies_metascore,
        fillcolor=list(width=0.5, color='rgb(127, 166, 238)'),
        #line=list(width=0.5, color='rgb(127, 166, 238)',
        line=list(width=1, color='rgb(127, 166, 238)'))
    
  })
  
  
  
  
}