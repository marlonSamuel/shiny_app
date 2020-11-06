
library(shiny)
library(ggplot2)
library(dplyr)

out_click = NULL
out_hover = NULL

# Define UI for application that draws a histogram
shinyUI(fluidPage(

    # Application title
    titlePanel("TAREA 4"),
    
    tabsetPanel(
        tabPanel("GRAFICA MTCARS DATASET",
                 h1("MTCARS"),
                 plotOutput('plot_mtcars',
                            click = 'click_plot',
                            dblclick = 'dblclck_plot',
                            hover = 'hover_plot',
                            brush = 'brush_plot'),
                 
                 DT::dataTableOutput('mtcars_dt')
                 )
    )
    

  
))
