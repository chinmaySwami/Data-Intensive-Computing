
library("plotly")
setwd("D:/University/Sem2/DIC/Projects/Lab1EDA/Part_2")
  
  # Chart 1 :- Influenza national summary (green and yellow chart)
  myData <- read.csv("Data/WHO_NREVSS_Clinical_Labs.csv",skip = 1)
  
  #  cleaning data and generating the yearWeek field
  myData$WEEK <- sprintf("%02d", myData$WEEK)
  myData$YearWeek <- paste0(myData$YEAR, myData$WEEK, sep="")
  
  #  Filtering data for retriving relevant records
  myDataC1 = subset(myData,myData$YearWeek > 201839)
  myDataC1
  
  yattributes <- list(
    rangemode = 'tozero',
    overlaying = "y",
    side = "right",
    title = "percent Positive",
    showgrid = FALSE, 
    zeroline = FALSE,
    showline=TRUE
  )
  
  p<- plot_ly(myDataC1)%>%
    add_trace(x =~myDataC1$YearWeek,y = ~myDataC1$PERCENT.B, name = '% Positive Flu B',type="scatter",
              mode = 'lines', line = list(color='Green',dash='dot'),yaxis ="y2")%>%
    add_trace(x =~myDataC1$YearWeek, y = ~myDataC1$PERCENT.A, name = '% Positive Flu A',type="scatter",
              mode = 'lines', line = list(color='#e6e600',dash='dash'),yaxis ="y2")%>%
    add_trace(x =~myDataC1$YearWeek, y = ~myDataC1$PERCENT.POSITIVE, name = 'Percent Positive',type="scatter",mode = 'lines', line = list(color='black'),yaxis ="y2")%>%
    add_trace(x =~myDataC1$YearWeek, y = ~myDataC1$TOTAL.B, name = 'B',marker = list(color = '#00ff00')) %>%
    add_trace(x =~myDataC1$YearWeek, y = ~myDataC1$TOTAL.A, name = 'A',marker = list(color = '#ffff00')) %>%
    layout(title = "Influenza Positive tests Reported to CDC by U.S. Clinical Laboratories,
    National Summary, 2018-2019 Season",
           yaxis = list(title = 'Number of Positive Specimens', showline=TRUE), 
           xaxis = list(title = "Weeks",tickangle = -45,tick = 0,dtick = 2),
           barmode = 'stack',yaxis2=yattributes)
  
  p

# Chart 2 :- Influenza national summary (green and yellow chart)

myData = read.csv("Data/WHO_NREVSS_Public_Health_Labs.csv",skip = 1)
#  cleaning data and generating the yearWeek field
myData$WEEK <- sprintf("%02d", myData$WEEK)
myData$YearWeek <- paste0(myData$YEAR, myData$WEEK, sep="")

#  Filtering data for retriving relevant records
myDataC2 = subset(myData,myData$YearWeek > 201839)
myDataC2

p<- plot_ly(myDataC2)%>%
  add_trace(x =~myDataC2$YearWeek, y = ~myDataC2$BYam, name = 'B (yamagata lineage)',marker = list(color = '#00cc00')) %>%
  add_trace(x =~myDataC2$YearWeek, y = ~myDataC2$BVic, name = 'B (Victoria lineage)',marker = list(color = '#00ff00')) %>%
  add_trace(x =~myDataC2$YearWeek, y = ~myDataC2$B, name = 'B (lineage not performed)',marker = list(color = '#339933')) %>%
  add_trace(x =~myDataC2$YearWeek, y = ~myDataC2$H3N2v, name = 'H3N2v',marker = list(color = '#0000ff')) %>%
  add_trace(x =~myDataC2$YearWeek, y = ~myDataC2$A..H3., name = 'A (H3N2)',marker = list(color = '#ff3300')) %>%
  add_trace(x =~myDataC2$YearWeek, y = ~myDataC2$A..2009.H1N1., name = 'A(H1N1) pdm09',marker = list(color = '#ff9900')) %>%
  add_trace(x =~myDataC2$YearWeek, y = ~myDataC2$A..Subtyping.not.Performed., name = 'A (Subtyping not performed)',marker = list(color = '#ffff00')) %>%
  layout(title = "Influenza Positive Tests Reported to CDC by U.S Public Health Laboratories,
         National Summary,2018-2019 Season",tickangle = 45,
    yaxis = list(title = 'Number of Positive Specimens', showline=TRUE), barmode = 'stack',
         xaxis = list(title = "Week", tick = 0, dtick = 2,tickangle = -45))

p


# Chart 5 :- Influenza-Associated Pediatric Mortality

myDataC5 = read.csv("Data/FluViewPhase4Data/Weekly.csv",skip = 1)
myDataC5$WEEK.NUMBER <- as.character(myDataC5$WEEK.NUMBER)
myDataC5$SEASON <- as.character(myDataC5$SEASON)
myDataC5 = subset(myDataC5,myDataC5$WEEK.NUMBER > "2015-39")
myDataC5

noOfDeath201516  = paste("Number of deaths reported =",
  sprintf("%3d",sum(subset(myDataC5$NO..OF.DEATHS,myDataC5$SEASON == "2015-16"))))

noOfDeath201617  = paste("Number of deaths reported =",
  sprintf("%3d",sum(subset(myDataC5$NO..OF.DEATHS,myDataC5$SEASON == "2016-17"))))

noOfDeath201718  = paste("Number of deaths reported =",
  sprintf("%3d",sum(subset(myDataC5$NO..OF.DEATHS,myDataC5$SEASON == "2017-18"))))

noOfDeath201819  = paste("Number of deaths reported =",
  sprintf("%3d",sum(subset(myDataC5$NO..OF.DEATHS,myDataC5$SEASON == "2018-19"))))


p<- plot_ly(myDataC5)%>%
  add_trace(x =~myDataC5$WEEK.NUMBER, y = ~myDataC5$CURRENT.WEEK.DEATHS, 
            name = 'Death reported current week',marker = list(color = '#0066ff'),
            text = ~noOfDeath201516,textposition='top center')%>%
  
  add_trace(x =~myDataC5$WEEK.NUMBER, y = ~myDataC5$PREVIOUS.WEEK.DEATHS, 
            name = 'Death reported previous week',marker = list(color = '#006600'))%>%

  layout(
    title = "<b>Number of Influenza - Associated Pediatric Deaths
    by Week of Death:</b>2015-2016 season to present",
         xaxis = list(title='<b>Week of Death</b>'),
         yaxis = list(title = '<b>Number of Positive Specimens</b>',
                      zeroline = TRUE,
                      showline= TRUE),
         barmode = 'stack',
         legend = list(orientation = 'h',xanchor = "center",x="0.5",y="-0.18",
                       bordercolor = "black",
                       borderwidth = 2),
         shapes=list(
           list(
              layer = "below",
              type = "rect",text="2016-17",
              fillcolor = "#e0e0eb", line = list(color = "#e0e0eb"), opacity = 0.4,
              x0 = "2016-40", x1 = "2017-39", xref = "x",
              y0 = 0, y1 = 30, yref = "y"),
           list(
             layer = "below",
             type = "rect",
             fillcolor = "#e0e0eb", line = list(color = "#e0e0eb"), opacity = 0.4,
             x0 = "2018-40", x1 = "2019-39", xref = "x",
             y0 = 0, y1 = 30, yref = "y")  
         ),
         annotations = list(
           list(
             text = "2015-2016",
             x = "2016-13",
             y = 24,
             showarrow=FALSE,
             font=list(size=16)
           ),
           list(
             text = noOfDeath201516,
             x = "2016-13",
             y = 23,
             showarrow=FALSE,
             font=list(size=12)
           ),
           list(
             text = "2016-2017",
             x = "2017-13",
             y = 24,
             showarrow=FALSE,
             font=list(size=16)
           ),
           list(
             text = noOfDeath201617,
             x = "2017-13",
             y = 23,
             showarrow=FALSE,
             font=list(size=12)
           ),
           list(
             text = "2017-2018",
             x = "2018-13",
             y = 24,
             showarrow=FALSE,
             font=list(size=16)
           ),
           list(
             text = noOfDeath201718,
             x = "2018-13",
             y = 23,
             showarrow=FALSE,
             font=list(size=12)
           ),
           list(
             text = "2018-2019",
             x = "2019-13",
             y = 24,
             showarrow=FALSE,
             font=list(size=16)
           ),
           list(
             text = noOfDeath201819,
             x = "2019-13",
             y = 23,
             showarrow=FALSE,
             font=list(size=12)
           )
         )
        )

p

# Chart 6 :- Influenza-like illness

generateData <- function(dataSet){
  # dataSet$WEEK <- sprintf("%02d", dataSet$WEEK)
  dataSet$WEEK <- paste0(" ",dataSet$WEEK,sep = " ")
  dataSet$WEEK = factor(dataSet$WEEK,levels = dataSet$WEEK)
  dataSet$WEEK
  return(dataSet)
}

myData = read.csv("Data/ILINet.csv",skip = 1)
myData$WEEK  = sprintf("%02d", myData$WEEK)
myData$yearWeek = paste0(myData$YEAR,myData$WEEK,sep="")
myDataC6 = subset(myData, myData$yearWeek > 200839)
myDataC6

myDataC62009to10 = subset(myDataC6, myDataC6$yearWeek > 200939 & myDataC6$yearWeek < 201040)
myDataC62009to10 = generateData(myDataC62009to10)

myDataC62010to11 = subset(myDataC6, myDataC6$yearWeek > 201039 & myDataC6$yearWeek < 201140)
myDataC62010to11 = generateData(myDataC62010to11)

myDataC62011to12 = subset(myDataC6, myDataC6$yearWeek > 201139 & myDataC6$yearWeek < 201240)
myDataC62011to12 = generateData(myDataC62011to12)

myDataC62012to13 = subset(myDataC6, myDataC6$yearWeek > 201239 & myDataC6$yearWeek < 201340)
myDataC62012to13 = generateData(myDataC62012to13)

myDataC62013to14 = subset(myDataC6, myDataC6$yearWeek > 201339 & myDataC6$yearWeek < 201440)
myDataC62013to14 = generateData(myDataC62013to14)

myDataC62014to15 = subset(myDataC6, myDataC6$yearWeek > 201439 & myDataC6$yearWeek < 201540 & myDataC6$yearWeek != 201453)
myDataC62014to15 = generateData(myDataC62014to15)

myDataC62015to16 = subset(myDataC6, myDataC6$yearWeek > 201539 & myDataC6$yearWeek < 201640)
myDataC62015to16 = generateData(myDataC62015to16)

myDataC62016to17 = subset(myDataC6, myDataC6$yearWeek > 201639 & myDataC6$yearWeek < 201740)
myDataC62016to17 = generateData(myDataC62016to17)

myDataC62017to18 = subset(myDataC6, myDataC6$yearWeek > 201739 & myDataC6$yearWeek < 201840)
myDataC62017to18 = generateData(myDataC62017to18)

myDataC62018to19 = subset(myDataC6, myDataC6$yearWeek > 201839 & myDataC6$yearWeek < 201940)
myDataC62018to19 = generateData(myDataC62018to19)

p <- plot_ly()%>%
  
  # add_trace(x = ~myDataC62009to10$WEEK,y = ~myDataC62010to11$X..WEIGHTED.ILI, name = 'Percent Positive Flu A',type="scatter",
  #           mode = 'lines', line = list(color='blue'))%>%
  
  # add_trace(x = ~myDataC62009to10$WEEK,y = ~myDataC62012to13$X..WEIGHTED.ILI, name = 'Percent Positive Flu A',type="scatter",
  #           mode = 'lines', line = list(color='blue'))%>%
  # add_trace(x = ~myDataC62009to10$WEEK,y = ~myDataC62013to14$X..WEIGHTED.ILI, name = 'Percent Positive Flu A',type="scatter",
  #           mode = 'lines', line = list(color='blue'))%>%
 
  add_trace(x = ~myDataC62009to10$WEEK,y = ~myDataC62017to18$X..WEIGHTED.ILI, name = '2017 -18 Season',type="scatter",
            mode = 'lines', line = list(color='#00ccff'))%>%
  add_trace(x = ~myDataC62009to10$WEEK,y = ~myDataC62016to17$X..WEIGHTED.ILI, name = '2016 -17 Season',type="scatter",
            mode = 'lines', line = list(color='#3366ff'))%>%
  add_trace(x = ~myDataC62009to10$WEEK,y = ~myDataC62015to16$X..WEIGHTED.ILI, name = '2015 -16 Season',type="scatter",
            mode = 'lines', line = list(color='#ff6600'))%>%
  add_trace(x = ~myDataC62009to10$WEEK,y = ~myDataC62014to15$X..WEIGHTED.ILI, name = '2014 -15 Season',type="scatter",
            mode = 'lines', line = list(color='#ff00ff'))%>%
  add_trace(x = ~myDataC62009to10$WEEK,y = ~myDataC62011to12$X..WEIGHTED.ILI, name = '2011 -12 Season',type="scatter",
            mode = 'lines', line = list(color='#33cc33'))%>%
  add_trace(x = ~myDataC62009to10$WEEK, y = ~myDataC62009to10$X..WEIGHTED.ILI, name = '2009 -10 Season',type="scatter",
            mode = 'lines', line = list(color='#ac7339'))%>%
  add_trace(x = ~myDataC62009to10$WEEK,y = 2.2, name = 'National Baseline',type="scatter",
            mode = 'line', line = list(color='black',dash='dash'))%>%
  add_trace(x = ~myDataC62018to19$WEEK,y = ~myDataC62018to19$X..WEIGHTED.ILI, name = '2018 -19 Season',type="scatter",
            mode = 'markers',marker = list(symbol='triangle-up',size = 10,color = "red",
                                           line = list(color = "black",size = 1)), line = list(color='red'))%>%
  layout(title = "Percentage of visits for Inluenza-like illness(ILI) Reported by the U.S. 
         Outpatient influenza-like illness Surveillence Network(ILINet), Weekly National Summary, 2018-2019 
         and Selected Previous Seasons",
         xaxis=list(title="Week"),yaxis = list(title="% of visits for ILI"),
         legend = list(bordercolor='#ac7339',
                       borderwidth=2))
	
p


# Chart 7 :- Flu heat map of USA
library(RColorBrewer)

myData <- read.csv("Data/US Heat Map/StateDataforMap_2018-19week4.csv")
usStatesData <- read.csv("Data/US Heat Map/US State abb.csv")
usStatesData
myData$stateCodes <- NULL
myData$levels <- 0

for (row in 1:nrow(myData)){
  myDataStateName = as.character(myData[row,'STATENAME'])
  if (myDataStateName == "New York City"){
    myData[row,'stateCodes'] <- "NY"
  }
  else{
    stateDetails <- subset(usStatesData,usStatesData$State.District  == myDataStateName)
    myData[row,'stateCodes'] <- stateDetails[1,'Postal.Code']
  }
  myData[row,'levels'] <- as.integer(unlist(strsplit(as.character(myData[row,'ACTIVITY.LEVEL'])," "))[2])  
} 
myData
# myData$stateAbb <- NULL
# for (row in 1:nrow(myData)){
#   myData[row,"stateAbb"] = state.abb[grep(myData[row,"STATENAME"],state.name)]
# }
# myData  
# 
# state.abb[grep("District of Columbia", state.name)]
# data(state)
# myData
# myData$stateAbb = state.abb[grep(myData$STATENAME, state.name)]
g <- list(
  scope = 'usa',
  projection = list(type = 'albers usa'),
  showlakes = TRUE,
  lakecolor = toRGB('white')
)
colors = c('yellow','green','red')
p <- plot_geo(myData,locationmode = 'USA-states')%>%
  add_trace(locations=myData$stateCodes, z=myData$levels,
             color = myData$levels,colors = colors ) %>% 
  layout(geo=g)

p

#  Chart 1 and 2 for entire 52 Weeks

myData <- read.csv("Data/WHO_NREVSS_Clinical_Labs.csv",skip = 1)
myData
#  cleaning data and generating the yearWeek field
myData$WEEK <- sprintf("%02d", myData$WEEK)
myData$YearWeek <- paste0(myData$YEAR, myData$WEEK, sep="")

#  Filtering data for retriving relevant records
myDataC1 = subset(myData,myData$YearWeek > 201739 & myData$YearWeek < 201840)
myDataC1

attributes <- list(
  rangemode = 'tozero',
  overlaying = "y",
  side = "right",
  title = "percent Positive",
  showgrid = FALSE, 
  zeroline = FALSE,
  showline=TRUE
)

p<- plot_ly(myDataC1)%>%
  add_trace(x =~myDataC1$YearWeek,y = ~myDataC1$PERCENT.B, name = '% Positive Flu B',type="scatter",
            mode = 'lines', line = list(color='Green',dash='dot'),yaxis ="y2")%>%
  add_trace(x =~myDataC1$YearWeek, y = ~myDataC1$PERCENT.A, name = '% Positive Flu A',type="scatter",
            mode = 'lines', line = list(color='#e6e600',dash='dash'),yaxis ="y2")%>%
  add_trace(x =~myDataC1$YearWeek, y = ~myDataC1$PERCENT.POSITIVE, name = 'Percent Positive',type="scatter",mode = 'lines', line = list(color='black'),yaxis ="y2")%>%
  add_trace(x =~myDataC1$YearWeek, y = ~myDataC1$TOTAL.B, name = 'B',marker = list(color = '#00ff00')) %>%
  add_trace(x =~myDataC1$YearWeek, y = ~myDataC1$TOTAL.A, name = 'A',marker = list(color = '#ffff00')) %>%
  layout(title = "Influenza Positive tests Reported to CDC by U.S. Clinical Laboratories,
         National Summary, 2017-2018 Season",
         yaxis = list(title = 'Number of Positive Specimens', showline=TRUE), 
         xaxis = list(title = "Weeks"),
         barmode = 'stack',yaxis2=attributes)

p


myData = read.csv("Data/WHO_NREVSS_Public_Health_Labs.csv",skip = 1)
#  cleaning data and generating the yearWeek field
myData$WEEK <- sprintf("%02d", myData$WEEK)
myData$YearWeek <- paste0(myData$YEAR, myData$WEEK, sep="")

#  Filtering data for retriving relevant records
myDataC2 = subset(myData,myData$YearWeek > 201739 & myData$YearWeek < 201840)
myDataC2

p<- plot_ly(myDataC2)%>%
  add_trace(x =~myDataC2$YearWeek, y = ~myDataC2$BYam, name = 'B (yamagata lineage)',marker = list(color = '#00cc00')) %>%
  add_trace(x =~myDataC2$YearWeek, y = ~myDataC2$BVic, name = 'B (Victoria lineage)',marker = list(color = '#00ff00')) %>%
  add_trace(x =~myDataC2$YearWeek, y = ~myDataC2$B, name = 'B (lineage not performed)',marker = list(color = '#339933')) %>%
  add_trace(x =~myDataC2$YearWeek, y = ~myDataC2$H3N2v, name = 'H3N2v',marker = list(color = '#0000ff')) %>%
  add_trace(x =~myDataC2$YearWeek, y = ~myDataC2$A..H3., name = 'A (H3N2)',marker = list(color = '#ff3300')) %>%
  add_trace(x =~myDataC2$YearWeek, y = ~myDataC2$A..2009.H1N1., name = 'A(H1N1) pdm09',marker = list(color = '#ff9900')) %>%
  add_trace(x =~myDataC2$YearWeek, y = ~myDataC2$A..Subtyping.not.Performed., name = 'A (Subtyping not performed)',marker = list(color = '#ffff00')) %>%
  layout(title = "Influenza Positive Tests Reported to CDC by U.S Public Health Laboratories,
         National Summary,2018-2019 Season",
         yaxis = list(title = 'Number of Positive Specimens', showline=TRUE), barmode = 'stack',
         xaxis = list(title = "Week"))

p


#  Chart 1 and 2 for Only NY Data

myData <- read.csv("Data/New York/WHO_NREVSS_Clinical_Labs.csv",skip = 1)
myData
#  cleaning data and generating the yearWeek field
myData$WEEK <- sprintf("%02d", myData$WEEK)
myData$YearWeek <- paste0(myData$YEAR, myData$WEEK, sep="")

#  Filtering data for retriving relevant records
myDataC1 = subset(myData,myData$YearWeek > 201739 & myData$YearWeek < 201840)
myDataC1

attributes <- list(
  rangemode = 'tozero',
  overlaying = "y",
  side = "right",
  title = "percent Positive",
  showgrid = FALSE, 
  zeroline = FALSE,
  showline=TRUE
)

p<- plot_ly(myDataC1)%>%
  add_trace(x =~myDataC1$YearWeek,y = ~myDataC1$PERCENT.B, name = '% Positive Flu B',type="scatter",
            mode = 'lines', line = list(color='Green',dash='dot'),yaxis ="y2")%>%
  add_trace(x =~myDataC1$YearWeek, y = ~myDataC1$PERCENT.A, name = '% Positive Flu A',type="scatter",
            mode = 'lines', line = list(color='#e6e600',dash='dash'),yaxis ="y2")%>%
  add_trace(x =~myDataC1$YearWeek, y = ~myDataC1$PERCENT.POSITIVE, name = 'Percent Positive',type="scatter",mode = 'lines', line = list(color='black'),yaxis ="y2")%>%
  add_trace(x =~myDataC1$YearWeek, y = ~myDataC1$TOTAL.B, name = 'B',marker = list(color = '#00ff00')) %>%
  add_trace(x =~myDataC1$YearWeek, y = ~myDataC1$TOTAL.A, name = 'A',marker = list(color = '#ffff00')) %>%
  layout(title = "Influenza Positive tests Reported to CDC by U.S. Clinical Laboratories,
         New York State Summary, 2017-2018 Season",
         yaxis = list(title = 'Number of Positive Specimens', showline=TRUE), 
         xaxis = list(title = "Weeks"),
         barmode = 'stack',yaxis2=attributes)

p


