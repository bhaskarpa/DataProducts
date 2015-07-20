library(shiny)
library(ggplot2)

bmiIndex <- function(height, weight, units) {
  bmi <- 0.0
  
  if (units == "Imperial(Pounds/Inches)") {
    bmi <- (weight/(height*height))*703
  }
  else {
    bmi <- (weight/(height*height))
  }
  bmi
}

bmiCategory <- function(bmi) {
  categoryInfo <- "<span style='color: green; font-size: 14pt; font-weight: bold'>Normal</span>"
  if (bmi < 16) {
    categoryInfo <- "<span style='color: #0404B4;font-size: 14pt;font-weight: bold'>Severly Underweight</span>"
  }
  else if ((bmi >= 16) & (bmi <= 17)) {
    categoryInfo <- "<span style='color: #2E64FE;font-size: 12pt;font-weight: bold'>Very Underweight</span>"
  }
  else if ((bmi > 17) & (bmi <= 18.5)) {
    categoryInfo <- "<span style='color: #00BFFF;font-size: 12pt'>Underweight</span>"
  }
  else if ((bmi > 18.5) & (bmi <= 25)) {
    categoryInfo <- "<span style='color: green;font-size: 12pt';font-weight: bold'>Normal</span>"
  }
  else if ((bmi > 25) & (bmi <= 30)) {
    categoryInfo <- "<span style='color: #FE642E;font-size: 12pt'>Overweight</span>"
  }
  else if ((bmi > 30) & (bmi <= 35)) {
    categoryInfo <- "<span style='color: #FF0000;font-size: 12pt'>Obese</span>"
  }
  else if ((bmi > 35) & (bmi <= 40)) {
    categoryInfo <- "<span style='color: #DF0101;font-size: 12pt;font-weight: bold'>Very Obese</span>"
  }
  else {
    categoryInfo <- "<span style='color: #B40404;font-size: 14pt;font-weight: bold'>Morbid Obese</span>"
  }
  
  categoryInfo
}

shinyServer(
  function(input, output) {
    units <- reactive({ as.character(input$units) })
    wt <- reactive({if (input$units == 'Imperial(Pounds/Inches)') {
       as.numeric(input$weight) } else { as.numeric(input$weightMetric)}})
    ht <- reactive({if (input$units == 'Imperial(Pounds/Inches)') {
      as.numeric(input$height) } else { as.numeric(input$heightMetric)}})

    bmi <- reactive( {bmiIndex(ht(), wt(), units())} )
    bmiCatInfo <- reactive( {bmiCategory(bmi())} )
    output$units <- renderText({paste0("<span style='color: #086A87;font-size: 12pt'>Units: ", units(), "</span>")})
    output$weight <- renderText({
      if (input$units == 'Imperial(Pounds/Inches)') {
        weightUnits <- 'Pounds'
      }
      else {
        weightUnits <- 'Kilograms'
      }
      
      paste0("<strong>Weight: ", wt(), " ", weightUnits, "</strong>")
    })
    
    output$height <- renderText({
      if (input$units == 'Imperial(Pounds/Inches)') {
        heightUnits <- 'Inches'
      }
      else {
        heightUnits <- 'Meters'
      }
      
      paste0("<strong>Height: ", ht(), " ", heightUnits, "</strong>")
    })

    output$bmi <- renderText(bmi())
    output$catInfo <- renderText(bmiCatInfo())
    
    output$graph <- renderText({
      "<img style='width: 40em; margin-top: 1em' src='http://www.freeonlinebmicalculator.com/images/bmichart.gif' title='Body mass index chart (chartsgraphsidiagrams.com)' />"  
    })
  }
)