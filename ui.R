library(shiny)
shinyUI(fluidPage( 
  titlePanel("Predict Temperature from amount of Wind"), 
  sidebarLayout(
    sidebarPanel( 
      h1("Instructions:"),
      h5("In this application, you can adjust the levels of Wind (in mph), to predict the temperature.  If you know whether or not it is summer, you can slide the summer slider to 1 for summer (June, July, Aug) or 0 for a non-summer month.  The first model (in red) will predict temperature if you don't know whether or not it is summer, while the 2nd model (in blue) will predict temperature based on wind and whether or not it is summer"),
      sliderInput("sliderWind","How Windy is it?",1,21,value = 10),
      h5("If you know whether or not it is Summer or not you can put a value (1 for Summer or 0 for Other).  Please do not put any fractional values here"),
      sliderInput("sliderSummer","Is it Summer?",0,1,value = 1),
      h5("Checking the showModel1 button will show a red line on the graph predicting Temperature based on Wind.  Likewise checking show model 2 will show a blue line with a model based on Summer and Wind"),
      checkboxInput("showModel1","Show/Hide Model 1",value = TRUE),
      checkboxInput("showModel2", "Show/Hide Model 2", value = TRUE),
      submitButton("Submit")
    ),
    mainPanel(  
       plotOutput("plot1"),
       h3("Predicted Temperature from Wind Model:"),
       textOutput("pred1"),
       h3("Predicted Temperature from Wind and Summer Model:"),
       textOutput("pred2")
    )
  )
))
