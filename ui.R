#ui.R
library(shiny)
shinyUI(
  pageWithSidebar(
    # Application title
    headerPanel("Interactive Noise/Error Manipulation "),
    sidebarPanel(
      sliderInput('beta', 'Reference Line Slope',value = 1, min = -5, max = 5, step = 0.005,),
      sliderInput('yint', 'Reference Line Y-intercept',value = 0, min = 0, max = 500, step = 10,),
      
      sliderInput('mean1', 'Random Normal Noise/Error Mean',value = 0, min = -50, max = 50, step = 1,),
      sliderInput('sd1', 'Random Normal Noise/Error SD',value = 50, min = 0, max = 50, step = 1,),
      radioButtons("plot_type", "Plot Type ",
                   c("Line/Smooth" = "line",
                     "Points" = "point"), selected ="point"),
      submitButton('Submit')
    ),
    mainPanel(
      plotOutput('gplot') ,
      p("Select properties 'Reference Line Slope', 'Reference Line Y-intercept', 'Random Normal Noise/Error Mean', 'Random Normal Noise/Error SD', and 'Plot Type' from the left side panel and click submit. ")
    )
   
  )
)