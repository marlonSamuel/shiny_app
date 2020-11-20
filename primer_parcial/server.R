library(shiny)
library(DBI)
library(pool)
library(RMySQL)
library(dplyr)
library(ggplot2)
library(plotly)


#conexion a base de datos
connection <- function(){
    return(dbConnect(
        drv = RMySQL::MySQL(),
        dbname = "academatica_db",
        host = "127.0.0.1",
        username = "root",
        password = ""))
}


conn <- connection()
#obtener data inicial
data = dbGetQuery(conn, "SELECT * FROM videos")
print(dim(data)[0])
#obtener data filtrada inicial
data_filter <<- data.frame()
#cerrar conexion
dbDisconnect(conn)



# Define server logic required to draw a histogram
shinyServer(function(input, output, session) {
    #filtrar por query
    getQuery <- function(query){
        conn = connection()
        queryData = dbGetQuery(conn,query)
        dbDisconnect(conn)
        return(queryData)
    }
    
    #renderizar opcion
    output$option <- renderText({
        input$option
    })
    
    #redireccionar a link de video top 10 seleccionado
    selectedCount <- eventReactive(input$count_table_rows_selected,{
        selectedrowindex <- as.numeric(input$count_table_rows_selected)
        data_f <- data_filter[selectedrowindex,]
        
        #browseURL(data_f['link'])
        output$frame_count <- renderText({
            return(as.character(data_f['iframe']))
        })
        
        as.character(data_f['title'])
        
    })
    
    #renderizar video seleccionado
    output$tab_count = renderText({
        selectedCount()
    })
 
    
    #grafica de barras segun opcion seleccionada
    output$count_data <- renderPlot({
        option = input$option
        query = paste("SELECT title,",option, ",video_id, iframe FROM VIDEOS", "ORDER BY",option,"DESC LIMIT 10")
        data_filter <<- getQuery(query)
        
        #data_filter$link <- paste0("<a href='",data_filter$link,"'>","ir a","</a>")
        
        output$count_table <- DT::renderDataTable({
          DT::datatable(data_filter[1:3],
                        options = list(dom = 't'),
                        selection = "single")  
        })
        names(data_filter)[2] = "count"
        
        
         ggplot(data_filter,aes(title, count,text = title))+
            geom_bar(stat="identity",position = "dodge",aes(fill = title))+
             geom_text(aes(label=count), 
                       position = position_dodge(width = 1))+
            theme(axis.title.x=element_blank(),
                  axis.text.x=element_blank(),
                  axis.ticks.x=element_blank())
        
    })
    
    #renderizar likes
    output$plot <- renderPlot({
        plot(data$likes, type=input$plotType)
    })
    
    #renderizar vistas por anioo
    output$plot_data_year <- renderPlot({
        query = getQuery("SELECT YEAR(CONVERT(published_at, DATE)) AS YEAR, COUNT(*) 
                         AS TOTAL
                         FROM videos 
                         GROUP BY YEAR(CONVERT(published_at, DATE))")
        
        df = data.frame(query)
        df<-df[-which(is.na(df$YEAR)),]
        
        output$table_year <- renderTable(df)
        
        output$plot_data_year <- renderPlot({
            O <-ggplot(df, aes(x=YEAR,y=TOTAL)) +
                
                geom_line(size = 1, alpha = 0.75) +
                geom_point(size =3, alpha = 0.75) +
                
                ggtitle("VIDEOS PUBLICADOS POR ANIO") +
                labs(x="YEAR",y="COUNT")+
                scale_x_continuous(labels = c(df$YEAR),breaks = c(df$YEAR))
                theme_classic()
            O
        })
    })
    
    #renderizar summary de tabla
    output$summary <- renderPrint({
        summary(data)
    })
    
    #contar total
    output$total <- renderInfoBox({
        infoBox(
            "Total de videos", paste0( nrow(data)),icon = icon("video"),
            color = "blue"
        )
    })
    
    #contar total de vistas
    output$total_views <- renderInfoBox({
        infoBox(
            "Total de vistas", sum(as.numeric(data$views), na.rm = TRUE),icon = icon("eye")
        )
        
    })
    
    #contar total de likes
    output$total_likes <- renderInfoBox({
        infoBox(
            "Total de likes", sum(as.numeric(data$likes), na.rm = TRUE),icon = icon("thumbs-up")
        )
    })
    
    #contar total dislikes
    output$total_dislikes <- renderInfoBox({
        infoBox(
            "Total de dislikes", sum(as.numeric(data$dislikes), na.rm = TRUE),icon = icon("thumbs-down"),
            color="red"
        )
    })
    
    #contar total comments
    output$total_comments <- renderInfoBox({
        infoBox(
            "Total de commentarios", sum(as.numeric(data$comments), na.rm = TRUE),icon = icon("comment"),
            color = "yellow"
        )
    })
    
    #renderizar total de registros de data inicial
    output$table <- DT::renderDataTable({
        DT::datatable(data, rownames=FALSE,
                      extensions = list(Scroller=NULL,  FixedColumns=list(leftColumns=2)),
                      selection = "single",
                      options = list(
                          dom = 'T<"clear">lfrtip',
                          autoWidth = TRUE,
                          columnDefs = list(list(width = '100%', targets = list(1:14))),
                          deferRender=TRUE,
                          scrollX=TRUE,scrollY=400,
                          scrollCollapse=TRUE,
                          pageLength = 10, lengthMenu = c(10,50,100,200)
                          
                      ))
    })
    
    #evento para seleccionar de tabla principal
    selectedRow <- eventReactive(input$table_rows_selected,{
        selectedrowindex <- as.numeric(input$table_rows_selected)
        data_f <- data[selectedrowindex,]
        text <- ""
        
        url <- a("ir a video", href=data_f['link'])
        output$tab <- renderUI({
            tagList("URL link:", url)
        })
        
        for (r in names(data_f)) {
            text = paste(text,r,':',data_f[r],"\n")
        }
        
        output$frame <- renderText({
            return(as.character(data_f['iframe']))
        })
        #print(names(data_f))
        text
        
        #selectedrow <- paste(data[selectedrowindex,],collapse = "\n ")
        #selectedrow
    })
    
    #mostrar informacion de fila seleccionada
    output$table_content_click = renderText({
        selectedRow()
    })
    
    #mostrar documentacion
    output$pdfview <- renderUI({
        host = "http://127.0.0.1:6171"
        file = "Docker_DS.pdf"
        url = paste0(host,'/',file)
        wwwPath <- paste0(getwd(),'/',file)
        print(wwwPath)
        
        tags$iframe(style="height:600px; width:100%", src=url)
    })

})
