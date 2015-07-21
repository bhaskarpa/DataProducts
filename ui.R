library(shiny)
library(ggplot2)

fluidPage(
  
  titlePanel("BMI Calculator & Weight Grader"),
  
  sidebarLayout(
    sidebarPanel(
      p("Specify the unit system to be used for BMI input metrics"),
      # Specification for Metric vs Pound System
      radioButtons("units", "Unit System:",
                   c("Imperial(Pounds/Inches)",
                     "Metric(Kilograms/Meters)")),
      
      p("Select the height and weight of the person using the sliders"),
      #
      # Show this panel only for metric system.
      #
      conditionalPanel(
        condition = "input.units == 'Imperial(Pounds/Inches)'",
        sliderInput('height', 'Height(inches)', min=24, max=108,
                    value=60, step=1, animate=TRUE),
        sliderInput('weight', 'Weight(pounds)', min=20, max=800,
                    value=110, step=1, animate=TRUE)
      ),
      conditionalPanel(
        condition = "input.units == 'Metric(Kilograms/Meters)'",
        sliderInput('heightMetric', 'Height(meters)', min=0.6, max=2.75,
                    value=1.5, step=0.1, animate=TRUE),
        sliderInput('weightMetric', 'Weight(kilograms)', min=9, max=363,
                    value=50, step=1, animate=TRUE)
      )
    ),
  
    #
    # Show the person's BMI score and weight category
    #
    mainPanel(
      uiOutput("units"),
      uiOutput("height"),
      uiOutput("weight"),
      h3("BMI Score:"),
      p(textOutput("bmi")),
      h3("Weight Grade:"),
      uiOutput("catInfo"),
      h4("Reference BMI Chart:"),
      uiOutput("graph")
    )
  ))
