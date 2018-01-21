
traumaModuleInput <- function(id) {
    ns <- NS(id)
    
    tagList(
        radioButtons(ns("calc_method"), "ISS Calculation Method", choices = c("Any AIS = 6; ISS = 75"=1, "All AIS = 6 -> AIS = 5; ISS calculated normally"=2)),
        radioButtons(ns("icd10"), "Include ICD 10?", choices = c("Yes" = T, "No" = F)),
        radioButtons(ns("i10_iss_method"), "ICD 10 ISS method", choices = c("ROC max (empirical)" = "roc_max", "GEM max" = "gem_max", "GEM min" = "gem_min")),
        textOutput(ns("switch_out")), br(), br(),
        textInput(ns("dx_pre"),label = "Diagnosis code prefix"),
        textOutput(ns("dx_cnt_out")), br(), br(),
        actionButton(ns("runButton"), "Run"),
        textOutput(ns("runButton_out1")),
        textOutput(ns("runButton_out2")),
        textOutput(ns("log"))
    )
}

traumaModule <- function(input, output, session, datafile) {
      # count dx and px codes in data
      regex_dx <- reactive({paste(input$dx_pre,"([0-9]+)",sep="")})
      dx_colnames <- reactive({grep(regex_dx(), names(datafile()), value = T)})
      dx_cnt <- reactive({ ifelse(input$dx_pre == "",0,length(dx_colnames()))})
    
    output$dx_cnt_out <- renderText({ paste(dx_cnt(),"diagnosis codes found")})
    output$runButton_out2 <- renderText({ifelse(input$runButton > 0, "Proceed to next step", "")})
    output$switch_out <- renderText(input$switch2)
  
    eventReactive(input$runButton,{
        output$runButton_out1 <- renderText("Running....")
        
        icdpicr::cat_trauma(datafile(), 
                            dx_pre = input$dx_pre, 
                            calc_method = input$calc_method, 
                            icd10 = input$icd10,
                            i10_iss_method = input$i10_iss_method)
        
      
    })
}


