#rm(list = ls())
library(shiny)

# Define server logic required to draw a histogram
shinyServer(function(input, output) {
  
  #slider 1
  output$slider1<-renderText({
    paste0(c('Output slider input: ',input$slider1),collapse = '')
  })
  
  #slider 2 range
  output$slider2<-renderText({
    paste0(c('Output slider input range: ',input$slider2),collapse = ' ')
  })
  
  #simple select
  output$select<-renderText({
    input$select 
  })
  
  #simple select multiple
  output$select2<-renderText({
    paste0(c('Selecciones del ui: ',input$select2), collapse = ' ') 
  })
  
  #date input
  output$date<-renderText({
    paste0(c('fecha: ',as.character(input$date)), collapse = '') 
  })
  
  #date range
  output$dates<-renderText({
    paste0(c('fechas: ',as.character(input$dates)), collapse = ' ') 
  })
  
  #numeric input
  output$num_input<-renderText({
    paste0(c('numero: ',input$num_input), collapse = ' ') 
  })
  
  #checkbox input
  output$checkbox<-renderText({
    paste0(c('valor: ',input$checkbox), collapse = ' ') 
  })
  
  #check group
  output$checkGroup<-renderText({
    paste0(c('valor: ',input$checkGroup), collapse = ' ') 
  })
  
  #input text
  output$text<-renderText({
    input$text 
  })
  
  #input text area
  output$textArea<-renderText({
    input$textArea 
  })
  
  #action button
  output$actionButton<-renderText({
    input$actionButton 
  })
  
  #action link
  output$actionLink<-renderText({
    input$actionLink 
  })
})
