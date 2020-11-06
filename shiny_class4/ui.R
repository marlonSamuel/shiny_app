#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)

# Define UI for application that draws a histogram
shinyUI(fluidPage(

    titlePanel("Ejemplo UI dinamico"),
    tabsetPanel(
                tabPanel('ejemplo 1',
                         numericInput("min",
                                       "Limite inferior",
                                       value = 5),
                          numericInput("max",
                                       "Liminte superior",
                                       value = 10),
                          sliderInput("slider_ej1",
                                      "seleccione intervalo",
                                      min=0,
                                      max=15,
                                      value=5)),
                
                tabPanel('ejemplo 2',
                         sliderInput('s1','s1',
                                     value=0,
                                     min = -5,
                                     max = 5),
                         sliderInput('s2','s2',
                                     value=0,
                                     min = -5,
                                     max = 5),
                         sliderInput('s3','s3',
                                     value=0,
                                     min = -5,
                                     max = 5),
                         sliderInput('s4','s4',
                                     value=0,
                                     min = -5,
                                     max = 5),
                         actionButton('clean','limpiar')),
                
                tabPanel('ejemplo 3',
                         numericInput('n','corridos',value = 10),
                         actionButton('correr','correr')),
                
                tabPanel('ejemplo 4',
                         numericInput('nvalue','nvalue',value = 10)),
                
                tabPanel('ejemplo 5',
                         numericInput('c','temperatura en grados celciues',value = NULL),
                         numericInput('f','temperatura en grados Farenhgeit',value = NULL)),
                
                tabPanel('ejemplo 6',
                         selectInput('dist',
                                     'Distribucion',
                                     choices = c('normal','uniforme','exponencial')),
                         numericInput('nrandom',
                                      'Numero de muestras',value = 100),
                         tabsetPanel(id='params',
                                     type='hidden',
                                     
                                     tabPanel('normal',
                                              numericInput('mean','Media',value = 0),
                                              numericInput('sd','Desviacion',value = 1)),
                                     
                                     tabPanel('uniforme',
                                              numericInput('min5','minimo',value = 0),
                                              numericInput('max5','maximo',value = 0)),
                                     
                                     tabPanel('exponencial',
                                              numericInput('taza','taza',value = 1, min = 0))
                                     
                                     ),
                         
                         plotOutput('plot_dist')
                         
                                     
                         )
               
        
        
    )
))
