#server.R
library(shiny)
library(UsingR)
library(ggplot2)




shinyServer(
  function(input, output) {
     output$gplot <- renderPlot({
      x <- seq(from=0, to=500, by=10)
      beta <-input$beta
      yint <- input$yint
      y <-  x * beta + yint
      y1 = yint
      y2 = yint + 500 * beta
      if(y1 > y2) {
        ymax = y1
      } else {
        ymax = y2
      }
      # this is for positioning text labels on plot
      ymax = abs(500 * beta) * 2.0  + abs(input$sd1 + 200) * 1.25
      yfactor =  ymax / 750 
      
      yo <- y + rnorm(length(x), mean=input$mean1, sd=input$sd1)
      dfa_xy <- data.frame(x=x, y=y, yo=yo)
      
      lmfit_o <- lm(yo ~ x, data=dfa_xy)
      lmfit_a <- lm(y ~ x, data=dfa_xy)
      
      xfit <- c(0, 500)
      yfit <- c (lmfit_o$coeff[1][1], 500 * lmfit_o$coeff[2][1] +lmfit_o$coeff[1][1])
      dfo_xy <- data.frame(x=xfit, y=yfit)
      
      #library(shiny)
      #library(knitr)
      #runApp()
      
      g <- ggplot(dfa_xy)
      
      if(input$plot_type == "line") {
          g <- g   + geom_smooth(aes(x=x, y=y,  colour="green" ) ) + geom_smooth(aes(x=x, y=yo, colour="red"))
      } else if(input$plot_type == "point") {
          g <- g   + geom_point(aes(x=x, y=y,  colour="green" ), size=2 ) + geom_point(aes(x=x, y=yo, colour="red"), size=2)
      }
      
      g <- g + annotate("text", x=80, y=ymax - 10 * yfactor, label = paste("Reference Line Slope = ", round(lmfit_a$coeff[2][1], 4)))
      g <- g + annotate("text", x=80, y=ymax - 40 * yfactor, label = paste("Reference Line Y-Int = ", round(lmfit_a$coeff[1][1], 4)))
      
       
      g <- g + annotate("text", x=80, y=ymax - 90 * yfactor, label = paste("Noisy line Slope = ", round(lmfit_o$coeff[2][1], 4)))
      g <- g + annotate("text", x=80, y=ymax - 120 * yfactor, label = paste("Noisy Line Y-Int = ", round(lmfit_o$coeff[1][1], 4)))      
      g <- g + geom_line(data=dfo_xy, aes(x=x, y=y,  colour="1" ), linetype=1)
      g <- g + geom_line( aes(x=x, y=y,  colour="10" ), linetype=1)
      g
    })
  } 
)
