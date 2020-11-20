library(markdown)
library(shiny)
library(shinydashboard)
library(DT)
library(shinyBS)

dashboardPage(
    dashboardHeader(disable = TRUE),
    dashboardSidebar(disable = TRUE),
    
    dashboardBody(
        fluidRow(
            navbarPage("ACADEMATICA IT",
                       tabPanel("Inicio",
                                fluidRow(
                                    # A static infoBox
                                    # Dynamic infoBoxes
                                    infoBoxOutput("total"),
                                    infoBoxOutput("total_views"),
                                    infoBoxOutput("total_likes"),
                                    infoBoxOutput("total_dislikes"),
                                    infoBoxOutput("total_comments"),
                
                                ),
                                
                                fluidRow(
                                    box(title = paste("Top 10 videos"), width = 12, status = "info",
                                        fluidRow(
                                            column(5,
                                                   selectInput("option","Seleccione opcion",
                                                               choices = c('likes','views','dislikes','favorites','comments')
                                                   ),
                                            ),
                                            column(12,
                                                   verbatimTextOutput("tab_count"),
                                                   htmlOutput("frame_count"),
                                                   DT::dataTableOutput('count_table'),
                                                   plotOutput("count_data")
                                                   )
                                        )
                                       
                                        
                                    )
                                ),
                                
                                fluidRow(
                                    box("Videos publicados por anio", width = 12, status = "info",
                                        column(3,
                                               tableOutput("table_year")
                                        ),
                                        column(9,
                                               plotOutput("plot_data_year")
                                        )
                                    )
                                    
                                ),
                                
                               
                       ),
                       tabPanel("Descripciones",
                                verbatimTextOutput("summary")
                       ),
                       navbarMenu("Mas",
                                  tabPanel("Contenido",
                                           fluidRow(
                                               column(12,
                                                      box(title="INFORMACION", width = 12, status = "primary", solidHeader = TRUE,
                                                          collapsible = TRUE,
                                                          uiOutput("tab"),
                                                          verbatimTextOutput("table_content_click"),
                                                          htmlOutput("frame")
                                                          
                                                      ),
                                               ),
                                               column(12,
                                                      box(title="Contenido", width = 12,
                                                          dataTableOutput("table")
                                                      )
                                                )
                                           )
                                           
                                           
                                  ),
                                  tabPanel("Manual",
                                           fluidRow(
                                                  box(width = 12,
                                                      title = "MANUAL TECNICO", status = "info", solidHeader = TRUE,
                                                      collapsible = TRUE,
                                                      uiOutput("pdfview")
                                                      
                                                  )
                                           )
                                  )
                       )
            )
        )
        
    )
)
