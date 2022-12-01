library(shiny)
library(shinythemes)
server <- function(input, output, session) {
  x <- reactive({
    set.seed(input$seed)
    switch (input$dist, 
            "Normal"=rnorm(input$m, input$mu, input$var),
            "Uniforme" = runif(input$m, input$a, input$b ),
            "Poisson" = rpois(input$m, input$lambdap),
            "Exponencial" = rexp(input$m, input$lambda),
            "Gamma" = rgamma(input$m, input$alfa, input$beta),
            "Binomial" = rbinom(input$nzinho, input$m, input$p))
  })
  
  nome <- reactive({
    switch (input$dist, 
            "Normal" = "Distribuição Normal",
            "Uniforme" = "Distribuição Uniforme",
            "Poisson" = "Distribuição Poisson",
            "Exponencial" = "Distribuição Exponencial",
            "Gamma" = "Distribuição Gamma",
            "Binomial" = "Distribuição Binomial")
  })
  
  
  ymean <- reactive({ 
    for (i in 1:input$m) {
      if (i==1) {
        ymean <- c(mean(sample(x(), size = input$N, replace = TRUE ))) 
      } else {
        ymean <- c(ymean,mean(sample(x(), size = input$N, replace = TRUE )))
      }}
    ymean
  })
  
  
  yvar <- reactive({ 
    for (i in 1:input$m) {
      if (i==1) {
        yvar <- c(var(sample(x(), size = input$N, replace = TRUE ))) 
      } else {
        yvar <- c(yvar,var(sample(x(), size = input$N, replace = TRUE )))
      }}
    yvar
  })
  
  
  compar1 <- reactive({
    for (i in 1:input$m) {
      if (i==1) {
        compar1 <- c(mean(sample(x(), size = input$N1, replace = TRUE ))) 
      } else {
        compar1 <- c(compar1,mean(sample(x(), size = input$N1, replace = TRUE )))
      }}
    compar1
    
  })
  
  compar2 <- reactive({
    for (i in 1:input$m) {
      if (i==1) {
        compar2 <- c(mean(sample(x(), size = input$N2, replace = TRUE ))) 
      } else {
        compar2 <- c(compar2,mean(sample(x(), size = input$N2, replace = TRUE )))
      }}
    compar2
    
  })
  
  compar3 <- reactive({
    for (i in 1:input$m) {
      if (i==1) {
        compar3 <- c(mean(sample(x(), size = input$N3, replace = TRUE ))) 
      } else {
        compar3 <- c(compar3,mean(sample(x(), size = input$N3, replace = TRUE )))
      }}
    compar3
    
  })
  
  
  
  output$hist <- renderPlot({
    hist(x() , main=nome(), col='lightblue', xlab='Valor de x', ylab='Densidade', freq = FALSE)
  })
  
  output$histmedia <- renderPlot({
    hist(ymean(), main = "Distribuição da Média Amostral", col='lightpink',  xlab='Valor de x', ylab='Densidade', freq=FALSE)
    curve(dnorm(x,mean=mean(ymean()),sd=sd(ymean())), add=TRUE,col="red", lwd=3)
  })
  
  output$hist1 <- renderPlot({
    hist(x() , main=nome(), col='lightblue', xlab='Valor de x', ylab='Densidade', freq = FALSE)
  })
  
  output$histvar <- renderPlot({
    hist(yvar(), main = "Distribuição da Variância Amostral", col='lightpink',  xlab='Valor de x', ylab='Densidade', freq=FALSE)
    curve(dnorm(x,mean=mean(yvar()),sd=sd(yvar())), add=TRUE,col="red", lwd=3)
  })
  
  output$histcompar <- renderPlot({
    hist(x() , main=nome(), col='lightblue', xlab='Valor de x', ylab='Densidade', freq = FALSE)
  })
  
  output$histcompar1 <- renderPlot({
    hist(compar1(), main = "Distribuição da Média Amostral 1", col='lightpink',  xlab='Valor de x', ylab='Densidade', freq=FALSE)
    curve(dnorm(x,mean=mean(compar1()),sd=sd(compar1())), add=TRUE,col="red", lwd=3)  
  })
  
  output$histcompar2 <- renderPlot({   
    hist(compar2(), main = "Distribuição da Média Amostral 2", col='lightpink',  xlab='Valor de x', ylab='Densidade', freq=FALSE)
    curve(dnorm(x,mean=mean(compar2()),sd=sd(compar2())), add=TRUE,col="red", lwd=3)   
  })
  
  output$histcompar3 <- renderPlot({ 
    hist(compar3(), main = "Distribuição da Média Amostral 3", col='lightpink',  xlab='Valor de x', ylab='Densidade', freq=FALSE)
    curve(dnorm(x,mean=mean(compar3()),sd=sd(compar3())), add=TRUE,col="red", lwd=3)
  })
  
  
  
}
