
library(shiny)

out_click<- NULL
out_hover<-NULL
out_dclick<- NULL

# Define server logic required to draw a histogram
shinyServer(function(input, output) {
    
    puntos = reactive({
        if(!is.null(input$hover_plot)){
            df<-nearPoints(mtcars,input$hover_plot,xvar='wt',yvar='mpg')
            out <- df %>% 
                select(wt,mpg)
            out_hover <<- out
            return(out)
        }
        
        if(!is.null(input$click_plot$x)){
            df<-nearPoints(mtcars,input$click_plot,xvar='wt',yvar='mpg')
            out <- df %>% 
                select(wt,mpg)
            out_click <<- rbind(out_click,out) %>% distinct()
            return(out)
        }
        
        if(!is.null(input$dblclck_plot)){
            df<-nearPoints(mtcars,input$dblclck_plot,xvar='wt',yvar='mpg')
            out <- df %>% 
                select(wt,mpg)
            
            out_click <<- setdiff(out_click,out)
            return(out)
        }
        
        if(!is.null(input$brush_plot)){
            df<-brushedPoints(mtcars,input$brush_plot,xvar='wt',yvar='mpg')
            out <- df %>% 
                select(wt,mpg)
            out_click <<- rbind(out_click,out) %>% dplyr::distinct()
            return(out)
        }
        
    })
    
    mtcars_plot = reactive({
        plot(mtcars$wt,mtcars$mpg,xlab="wt",ylab="Miles per Galon")
        puntos = puntos()
        if(!is.null(out_hover)){
            points(out_hover[,1],out_hover[,2],
                   col='gray',
                   pch=16,
                   cex=2)}
        
        if(!is.null(out_click)){
            points(out_click[,1],out_click[,2],
                   col='green',
                   pch=16,
                   cex=2)}
        
    })

    output$plot_mtcars <- renderPlot({
        mtcars_plot()
    })
    
    click_table = reactive({
        input$click_plot$x
        input$dblclck_plot$x
        input$brush_plot
        out_click
    })
    
    
    output$mtcars_dt = DT::renderDataTable({
        click_table() %>% DT::datatable()
    })

})
