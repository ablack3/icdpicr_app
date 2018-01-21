# ICDPIC app
library(shiny)
library(shinydashboard)
library(dplyr)
library(tidyr)
library(purrr)
library(icdpicr)

# options(shiny.reactlog=T) # command f3 + right arrow

source("./text_html.R")
source("./uploadModule.R")
source("./downloadModule.R")
source("./traumaModule.R")


ui <- dashboardPage(
           
    dashboardHeader(title="ICDPIC-R"),
    dashboardSidebar(
        sidebarMenu(
            menuItem("0) Welcome", tabName = "welcome", icon = icon("home")),
            menuItem("1) Instructions", tabName = "instructions", icon = icon("list")),
            menuItem("2) Upload Data", tabName = "upload", icon = icon("level-up")),
            menuItem("3) Add Variables", tabName = "compute", icon = icon("cogs")),
            menuItem("4) Download Data", tabName = "download", icon = icon("level-down")),
            menuItem("Help", tabName = "help", icon = icon("question"))
        )
    ),
        
    dashboardBody(
        tabItems(
            tabItem(tabName = "welcome", box(width=12, welcome_html())),
            tabItem(tabName = "help", box(width=12, help_html())),
            tabItem(tabName = "instructions", box(width=12, instructions_html())),
            tabItem(tabName = "upload",
                    fluidRow(
                        box(width=12,uploadModuleInput("datafile")),
                        box(width=12,div(style = 'overflow-x: scroll', dataTableOutput("input_table")))
                    )
            ),
            tabItem(tabName = "compute",
                    fluidRow(
                        box(width=12,
                            radioButtons("modules", "Module", 
                                     choices = c("ICD-9-CM Trauma"="trauma"), 
                                     selected = NULL, inline = FALSE, width = NULL)
                        ),
                        box(width=12,
                            conditionalPanel('input.modules == "trauma"', traumaModuleInput("trauma"))
                        )
                    )
            ),
            tabItem(tabName = "download",
                fluidRow(
                    box(width=12, downloadModuleInput("download")),
                    box(width=12, div(style = 'overflow-x: scroll', dataTableOutput("output_table")))
                )
            )
            
            
        )
    )
)



server <- function(input, output, session) {
   
    datafile <- callModule(uploadModule, "datafile")
  
    data_check1 <- reactive({ ifelse(nrow(datafile())>1, T, F) })
  
    trauma_out <- callModule(traumaModule, "trauma", datafile)

    output$input_table <- renderDataTable({ datafile()})

    output_table <- reactive({
        # print(input$modules) # for debugging
        d <- datafile()
        if(input$modules == "trauma") d <- trauma_out()
        d
    })
  
    # observe({print(output_table())}) #for debugging
    callModule(downloadModule, "download", output_table)
  
    # outputs 
    output$output_table <- renderDataTable({ output_table() })
    output$data_check1_out <- renderText({ paste("data_check1:", data_check1()) })
    output$modules_out <- renderPrint({ input$modules })
    
    
    outputOptions(output, "output_table", suspendWhenHidden=FALSE)
  
}

shiny::shinyApp(ui, server)
