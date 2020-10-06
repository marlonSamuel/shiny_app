#rm(list = ls())

library(shiny)

# Define UI for application that draws a histogram
ui <- fluidPage(
  
  # Application title
  titlePanel("Basic controls"),
  
  fluidRow(
    tabsetPanel(type = "tabs",
                tabPanel('Input examples',
                         column(6,
                                sliderInput("slider1", h4("number of bins"),
                                            min = 0, max = 100, value = 50, post = "%"),
                                sliderInput("slider2", "sleccione un rango",
                                            min = 0, max = 100, value = c(25, 75)),
                                selectInput("select", h4("Seleccione un auto"), 
                                            choices = row.names(mtcars), multiple = FALSE, selected = "Valiant"),
                                selectInput("select2", h4("Seleccione autos"), 
                                            choices = row.names(mtcars), multiple = TRUE, selected = "Valiant"),
                                dateInput("date", 
                                          h4("Ingrese fecha"), 
                                          value = date(), min = date(), language = "es", weekstart = 1),
                                dateRangeInput("dates", h4("Ingrese fechas")),
                                numericInput("num_input", 
                                             h4("Ingrese numero"), 
                                             value = 1),
                                checkboxInput("checkbox", "Seleccione si es verdadero", value = TRUE),
                                checkboxGroupInput("checkGroup", 
                                                   h4("seleccione opciones"), 
                                                   choices = list("A" = 'A', 
                                                                  "B" = 'B', 
                                                                  "C" = 'C',
                                                                  "D" = 'D',
                                                                  "E" = 'E'),
                                                   selected = 'A'),
                                textInput("text", h4("Ingrese texto"), 
                                          value = "hola mundo"),
                                textAreaInput("textArea",h4("ingrese parrafo"), value = "hola mundo"),
                                actionButton("actionButton","ok"),
                                actionLink("actionLink","siguiente"),
                                submitButton(text = "preprocesar")
                         ),
                         column(6, 
                                h2("Slider input"),
                                verbatimTextOutput("slider1"),
                                h2("Slider input rango"),
                                verbatimTextOutput("slider2"),
                                h2("select input"),
                                verbatimTextOutput("select"),
                                h2("select input multiple"),
                                verbatimTextOutput("select2"),
                                h2("Fecha"),
                                verbatimTextOutput("date"),
                                h2("Rango de fechas"),
                                verbatimTextOutput("dates"),
                                h2("Numeric input"),
                                verbatimTextOutput("num_input"),
                                h2("single Checkbox input"),
                                verbatimTextOutput("checkbox"),
                                h2("Checkbox gropu"),
                                verbatimTextOutput("checkGroup"),
                                h2("Texto"),
                                verbatimTextOutput("text"),
                                h2("Parrafo"),
                                verbatimTextOutput("textArea"),
                                h2("Action Button"),
                                verbatimTextOutput("actionButton"),
                                h2("Action Link"),
                                verbatimTextOutput("actionLink"),
                         )
                         
                )
                
    ),
    
  )
  
)
