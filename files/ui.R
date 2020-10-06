
library(shiny)
library(DT)

shinyUI(fluidPage(

    # Application title
    titlePanel("Cargar Archivos y dataframes"),
    
    tabsetPanel(
        tabPanel("Cargar Archivo",
                 sidebarLayout(
                     sidebarPanel(
                         h2("Subir Archivo"),
                         fileInput("upload_file_1","archivo...", buttonLabel = "Cargar")
                        ),
                     mainPanel(
                         tableOutput("contenido_archivo_1")
                        )
                    )
            ),
        
        tabPanel("Cargar Archivo DT",
                 sidebarLayout(
                     sidebarPanel(
                         h2("Subir Archivo"),
                         fileInput("upload_file_2",
                                   "seleccione archivo", 
                                   buttonLabel = "Cargar",
                                   accept = c(".csv",".tsv"))
                     ),
                     mainPanel(
                         DT::dataTableOutput("contenido_archivo_2")
                     )
                 )
        ),
        
        tabPanel("DT Option",
                 h2("Formato columna"),
                 hr(),
                 fluidRow(column(width=12,
                                 DT::dataTableOutput("tabla1"))),
                 
                 h2("Opciones"),
                 hr(),
                 fluidRow(column(width=12,
                                 DT::dataTableOutput("tabla2"))
                 ),
                 
                 h2("Opciones tabla 3"),
                 hr(),
                 fluidRow(column(width=12,
                                 DT::dataTableOutput("tabla3"))
                 )
        ),
        
        tabPanel("Clicks tabla",
                    fluidRow(column(width=12,
                                    h2("click en una fila"),
                                    dataTableOutput("tabla4"),
                                    verbatimTextOutput("tabla_4_single_click")
                                    )
                             ),
                 
                     fluidRow(column(width=12,
                                     h2("click en una filas"),
                                     dataTableOutput("tabla5"),
                                     verbatimTextOutput("tabla_5_multi_click")
                                     )
                                ),
                 
                 fluidRow(column(width=12,
                                 h2("click en una columna"),
                                 dataTableOutput("tabla6"),
                                 verbatimTextOutput("tabla_6_single_click")
                                )
                            ),
                 
                 fluidRow(column(width=12,
                                 h2("click en multiple columnas"),
                                 dataTableOutput("tabla7"),
                                 verbatimTextOutput("tabla_7_multi_click")
                                )
                            ),
                 fluidRow(column(width=12,
                                 h2("click en una celda"),
                                 dataTableOutput("tabla8"),
                                 verbatimTextOutput("tabla_8_single_click")
                                )
                            ),
                 
                 fluidRow(column(width=12,
                                 h2("click en multiple celdas"),
                                 dataTableOutput("tabla9"),
                                 verbatimTextOutput("tabla_9_multi_click")
                 )
                 )
                 )
    )
    
   
    
    
))
