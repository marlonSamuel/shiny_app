
library(shiny)
library(DT)
library(ggplot2)
library(dplyr)

shinyServer(function(input, output) {
    
    archivo_carga1 = reactive({
        if(is.null(input$upload_file_1)){
            return(NULL)
        }
        print(input$upload_file_1$type)
        ext = strsplit(input$upload_file_1$name,split = "[.]")[[1]][2]
        
        if(ext == 'csv'){
            
            file_data=read.csv(input$upload_file_1$datapath) 
            return(file_data)
        }
        return(NULL)
        
    })
    
    output$contenido_archivo_1 = renderTable({
        archivo_carga1()
    })
    
    archivo_carga2 = reactive({
        if(is.null(input$upload_file_2)){
            return(NULL)
        }
        print(input$upload_file21$type)
        ext = strsplit(input$upload_file_2$name,split = "[.]")[[1]][2]
        
        if(ext == 'csv'){
            file_data=read.csv(input$upload_file_2$datapath) 
            return(file_data)
        }
        return(NULL)
        
    })
    
    output$contenido_archivo_2 = DT::renderDataTable({
        archivo_carga2()%>%DT::datatable(filter = "top")
    })
    
    output$tabla1 = DT::renderDataTable({
        diamonds %>%
            datatable() %>%
            formatCurrency("price") %>%
            formatString(c("x","y","z"),suffix = " mn")
            
    })
    
    output$tabla2 = DT::renderDataTable({
        mtcars %>% 
            DT::datatable(options = list(pageLength=5,
                                         lengthMenu=c(5,10,15)),
                          filter = "top")
        
    })
    
    output$tabla3 = DT::renderDataTable({
        iris %>%
            datatable(extensions = "Buttons",
                      options = list(dom="Bfrtip",
                                     buttons=c("csv")))
    })
    
    output$tabla4 = renderDataTable({
        mtcars %>% datatable(selection = "single")
    })
    
    output$tabla_4_single_click = renderText({
        input$tabla4_rows_selected
    })
    
    output$tabla5 = renderDataTable({
        mtcars %>% datatable()
    })
    
    output$tabla_5_multi_click = renderText({
        input$tabla5_rows_selected
    })
    
    output$tabla6 = renderDataTable({
        mtcars %>% datatable(selection = list(mode="single",target="column"))
    })
    
    output$tabla_6_single_click = renderText({
        input$tabla6_columns_selected
    })
    
    output$tabla7 = renderDataTable({
        mtcars %>% datatable(selection = list(mode="multiple",target="column"))
    })
    
    output$tabla_7_multi_click = renderText({
        input$tabla7_columns_selected
    })
    
    output$tabla8 = renderDataTable({
        mtcars %>% datatable(selection = list(mode="single",target="cell"))
    })
    
    output$tabla_8_single_click = renderText({
        input$tabla8_cells_selected
    })
    
    output$tabla9 = renderDataTable({
        mtcars %>% datatable(selection = list(mode="multiple",target="cell"))
    })
    
    output$tabla_9_multi_click = renderPrint({
        input$tabla9_cells_selected
    })

})
