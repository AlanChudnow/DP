# https://alanchudnow.shinyapps.io/ShinyProject_v1/
# library(shinyapps)
# deployApp('ShinyProject_v1')

calc <-function(ind,intm, ints, nDkm){
    
    s <- c("", "", "", "", "", "")
    
        #Facts about prior race
    dm <- ind          #Distance in m
    dkm <- dm/1000.0     #distance in km
    dmiles <- dkm/1.609  #Distance in miles
    
    s[1] <- paste("Race Distance: ",round(dm)," (m) ",
               round(dmiles,2), " (miles)",
               sep="")
    
    tsec <- intm*60 + ints  #Time in Seconds
    tmin <- tsec/60                   #Time in Minutes
    th <- tmin/60                     #Time in Hours
    
    thf <- floor(th)
    tmf <- floor(tmin - thf*60)
    tms <- floor(tsec - thf*3600 - tmf*60)
    
    s[2]  <- paste("Race Time: ",thf, ":" ,tmf, ':', round(tms,1),
                            sep="")
    
    vMperS <- dkm*1000.0/tsec           #Velocity in Meters/sec
    vMperM <- vMperS*60.0               #Velocity in Meters/min
    vMPH <- vMperS * 2.23694          #Velocity in Miles/hour
    vMinPerMile <- 1/(vMPH/60.0)        #Velocity in Min Per Mile
    vMinPerKM <- 1/(vMperS/1000.0*60.0)   #Velocity in Min Per KM
    
    s[3] <- paste("Race Pace: ",round(vMperS,2),"(meters/sec)",
                            round(vMPH,2), "(MPH)",
                            round(vMinPerMile,2), "(Min per Mile)",
                            round(vMinPerKM,2), "(Min per KM) ",
                            round(vMperM,2),"(Meters per Min)",
                            sep=" ")     
    
    v <- vMperM
    vo2 <- -4.60 + 0.182258 * v + 0.000104 * v*v #Vo2 v in meters/min
    
    s[4] = paste("Race vo2: ",round(vo2,1), sep="")
    
    
    t <-  tmin
    percent_max <- 0.8 + 0.1894393 * exp(-0.012778 * t) + 
        0.2989558 * exp(-0.1932605 * t) #t in minutes
    vo2max <-  vo2/percent_max 
    
    s[5] <- paste("Race vo2max: ",round(vo2max,1), sep="")
 
    
    nTime = uniroot(  function(t) {
                            v = (nDkm) / t
                            v2 <- -4.60 + 0.182258 * v + 0.000104 * v*v
                            pm <- 0.8 + 0.1894393 * exp(-0.012778 * t) + 
                                 0.2989558 * exp(-0.1932605 * t) 
                         return(vo2max - v2/pm)
                         }, 
                      c(1,24*60*3), tol=0.001
                      )
    #print(nTime)

    s[6] <- paste("Predicted Race Time: ", round(nTime$root,2), "(min) assuming same V02max", sep=" ")
    
    return(s)  
    
}

shinyServer(
    function(input, output) {
        output$oDstring <- renderText({calc(input$iDkm,input$iTm,input$iTs,input$nDkm)[1]})
        output$oTString <- renderText({calc(input$iDkm,input$iTm,input$iTs,input$nDkm)[2]})
        output$oVString <- renderText({calc(input$iDkm,input$iTm,input$iTs,input$nDkm)[3]})
        output$oVo2pace <- renderText({calc(input$iDkm,input$iTm,input$iTs,input$nDkm)[4]})
        output$oVo2max  <- renderText({calc(input$iDkm,input$iTm,input$iTs,input$nDkm)[5]})
        output$oTpredict<- renderText({calc(input$iDkm,input$iTm,input$iTs,input$nDkm)[6]})
    }
)
