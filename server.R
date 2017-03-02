library(shiny)


shinyServer(function(input, output) {
  airquality$Summer = ifelse(airquality$Month == 6 | airquality$Month == 7 | airquality$Month == 8,1,0)
  model1 = lm(Temp~Wind,data = airquality)
  model2 = lm(Temp~Wind+as.factor(Summer),data = airquality)
  
  model1pred = reactive({  
    WindInput = input$sliderWind
    predict(model1,newdata = data.frame(Wind = WindInput))
  })
  
  model2pred = reactive({
    WindInput = input$sliderWind
    SummerInput = input$sliderSummer
    predict(model2,newdata = 
              data.frame(Wind=WindInput,Summer = SummerInput))
  })
  output$plot1 = renderPlot({
    WindInput = input$sliderWind
    SummerInput = input$sliderSummer
    plot(airquality$Wind,airquality$Temp,xlab = 'Wind',
         ylab = 'Temperature',bty = 'n',pch = 16,
         xlim = c(1,21),ylim = c(50,100))
    if(input$showModel1){
      abline(model1,col = 'red',lwd = 2)
    }
    if(input$showModel2){
      model2lines = predict(model2,newdata = data.frame(
        Wind = 1:21,Summer= SummerInput
      ))
      lines(1:21,model2lines,col = 'blue',lwd = 2)
    }
    legend(50,100,c("Model 1 Prediction","Model 2 Prediction"),pch = 16,
           col =c("red","blue"),bty = "n",cex = 1.2)
    points(WindInput,model1pred(),col = "yellow",pch = 16,cex = 2) 
    points(WindInput,model2pred(),col = "blue",pch = 16,cex = 2)
  })
  
  output$pred1 = renderText({
    model1pred()
  }) 
  
  output$pred2 = renderText({
    model2pred()
  })
})
