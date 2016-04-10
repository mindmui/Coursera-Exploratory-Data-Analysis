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
      # Base plotting functions:
        plot # make a scatterplot
        lines # to add lines to a plot
        points # to add points
        text # to add text labels
        title # add annotations to x,y axis labels
        mtext
        axis
        # example:
          with(airquality,plot(Wind,Ozone,main="Ozone in NY"))
        # adding a regression line
          model <- lm(Ozone~Wind, airquality)
          abline(model, lwd=2) #lwd make the line thicker
        # multiple plots
          par(mfrow = c(1,2)) # 1 row 2 columns
          with(airquality, {
            plot(Wind,Ozone)
            plot(Solar.R,Ozone)
          })
      # Base Plotting Demonstration
        x <- rnorm(1000)
        hist(x)
        text(-3,10, "mind")
        legend("topleft", legen="try")
        # check margin:
          par("mar")
        # specify margin:
          par(mar = c(2,2,1,1))
        # re plot
          hist(x)
        
          x <- rnorm(100)  
          y <- x + rnorm(100)
          g <- gl(2,50, labels = c("Male","Female"))
          plot(x,y, type ="n") #blank plot
          # to add data in
            points(x[g=="Male"],y[g=="Male"],col="red")
            points(x[g=="Female"],y[g=="Female"],col="blue",pch=19)
# Graphics Devices in R
    # is something where you can make a plot appear
        # a window on your screen - most common
        # a PDF file
        # a PNG or JPEG
    ?Devices # full list of devices
    # For quick visualisation and exploratory analysis
      # usually you want to use the screen device
    # How does a plot get created?
      # 1. call a plotting function like plot, xyplot, or qplot
      # 2. plot appears on the screen device
      # 3. annotate the plot if necessary
    # Another approach to plotting
      # this is commonly used FOR FILE DEVICES:
      # 1. Explicitly launch a graphics device
      # 2. Call a plotting function to make plot
        # but the plot will not appear! since your device is not the cscreen
      # 3. Annotate plot if necessary
      # 4. Close the graphic device using:
        dev.off() #*** very IMPORTANT
      # example:
        pdf(file = "myplot.pdf") # open PDF file
        with(faithful, plot(eruptions, waiting)) # to plot
        title(main = "old faithful data") # annotate plot
        dev.off() # don't forget to close the device
# Graphics File Devices:
  # 1. Vector formats: pdf, svg, postscript
    # useful for line-type but not where you have a lot of points
  # 2. Bitmap formats: png, jpeg, tiff, bmp
    # represent as series of pixels
    # good for plotting many many points
    # in general, it doesn't resize well! -- get distorted
  # Multiple open graphics devices:
    # we can open as many as graphics devices: 
      # e.g. by calling:
          quartz() # we open a new screen device
    # HOWEVER, we can only plot ONE by ONE
    # the current active device can be found by calling:
      dev.cur()
    # to set active device:
      dev.set(n) # n = to some integer
  # Copying plots 
    # copy the plot from screen device --> file device
      dev.copy()
      dev.copy2pdf()
    # note: copying a plot is not an exact operation
    # example:
      library(datasets)
      with(faithful, plot(eruptions,waiting)) # to plot
      title(main = "this is the title") # to annotate
      dev.copy(png, file="geyserplot.png") # copy to png device
      dev.off() # close the png device
      