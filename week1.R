# Week 1
# Principles of Analytic Graphics
  # 1. Show comparisons
  # 2. Show causality, mechanism, how the things work
  # 3. Show multivariate data
  # 4. Integrate multiple modes of evidence (graph,plot,text,chart)
  # 5. Describe and document the evidence
  # 6. Content is king - think of what you want to present

# Exploratory Graphs
  # "quick and dirty"
  # let you summarize the data graphically
  # explore the basic questions and hypotheses
boxplot(pollution$pm25, col="blue")
hist(pollution$pm25, col="green")
rug(pollution$pm25) # to plot the real data
  # change the break of histogram 
    hist(pollution$pm25, col="green", break = 100) 
# to draw a line    
  abline(v=12) # v=vertical
  abline(h=10) # h=horizontal
barplot(table(pollution$region), col="wheat", main="titlehere")
# Two dimensional data
  boxplot(pm25~region, data = pollution, col="red")
  # scatter plot
  with(pollution, plot(latiture,pm25))
  # add color for another variable
  with(pollution, plot(latiture,pm25, col = region))

# Plotting system in R
  # 1. Base Plotting System:
    # start with blank canvas and build up one by one
    # start with a plot function
    # = generation + annotation
    # the drawback is that you can't go back!
      # it's cumulative process
    # example:
    library(datasets)
    data(cars)
    with(cars, plot(speed,dist))
  # 2. Lattice System:
    # plots are created with a single function call
    # most useful for conditioning types of plots
    # cannot add or modify once created
    # example:
      library(lattice)
      state <- data.frame(state.x77, region = state.region)
      xyplot(Life.Exp ~ Income | region, data=state, layout = c(4,1))
  # 3. ggplot2 system
    # splits the difference between base and lattice
    # automatically deals with spacings, text, titles but also
      # allows you to annotate by 'adding' to a plot
    # more intuitive to use than lattice
    # example:
      library(ggplot2)
      data(mpg)
      qplot(display, hwy, data=mpg)
      
# Base Plotting Functions
  # most common for 2-D graphics
  # two phases:
      # 1. initializing
      # 2. annotaing an existing plot
  # example: histogram
      library(datasets)
      hist(airquality$Ozone) ## draw a new plot
      
      library(datasets)
      with(airquality, plot(Wind, Ozone))
      
      library(datasets)
      airquality <- transform(airquality,Month=factor(Month))
      boxplot(Ozone~Month, airquality,xlab="month",ylab="Ozone(ppb)")
      # key graphics parameters:
        pch # plotting symbol - default is open circle
        lty # line type - default is solid lide
        lwd # line width, specified as an integer
        col # colour, specified as a number, string, or hex code
        xlab # x-axis label
        ylab # y-axis label
      # for others parameters: which are global graphics parameters
        par()
        las # the orientation of axis lables
        bg # background color
        mar # margin size
        oma # outer margin (for multiple plot per page)
        mfrow # for multiple plot - specify how many rows
        mfcol # for multiple plot - specify how many columns
      