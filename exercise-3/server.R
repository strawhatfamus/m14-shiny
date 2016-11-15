# server.R
library(dplyr)
library(shiny)

# Read in data
source('./scripts/buildMap.R')
df <- read.csv('./data/electoral_college.csv', stringsAsFactors = FALSE)
state.codes <- read.csv('./data/state_codes.csv', stringsAsFactors = FALSE)

# Join together state.codes and df
joined.data <- left_join(df, state.codes, by="state")

# Compute the electoral votes per 100K people in each state
joined.data <- joined.data %>% mutate(ratio = votes/population * 100000)

# Start shinyServer
shinyServer(function(input, output) { 
  
  # Render a plotly object that returns your map
  output$map <- renderPlotly({ 
      return(BuildMap(joined.data, input$mapvar))
  })
})