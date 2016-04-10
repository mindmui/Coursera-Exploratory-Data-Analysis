# Week 2
# Lattice Plotting System:
    # build on top of packages
    # no two phase aspect! - here we create entire plot in single funciton call
  # Lattice Functions:
    xyplot # for scatter
    bwplot # box plot
    histogram 
    stripplot # box plot with actual points
    dotplot # plot dots on violin strings
    splom # scatterplot matrix
    levelplot # for plotting image data
    contourplot  # for plotting image data
  
  # xy-plot  
   xyplot(y ~ x | f * g, data)
    # where f and g are conditioning variables - optional
    # example:
   library(lattice)
   library(datasets)
   xyplot(Ozone~Wind,data = airquality)
    # more complicated:
    # multidimensional scatter:
    airquality <- transform(airquality, Month = factor(Month))
    xyplot(Ozone~Wind|Month,data=airquality,layout=c(5,1))
      # relationship between ozone and wind
      # using factor as Month
    # we can save plot object:
      p <- xyplot(Ozone~Wind,data=airquality)
      print(p) # to make plot appears
  
  # Lattice Panel Functions:
    ## Custom panel function
      xyplot(y~x|f, panel = function(x,y,...){
        panel.xyplot(x,y,...) # first call the default panel function
        panel.abline(h=median(y), lty=2) # add a horizontal line at the median
        panel.lmline(x, y, col = 2) # overlay a simple regression line to a panel   
       })
      # you can't use base plotting here!
  ### Summary ###
    # Lattice plots are constructed with a single function call
    # aspects like margins and spacing are automatically handled and defaults are usually sufficient
    # the lattice system is ideal for creating conditioning plots when you examine
      # the same kind of plots under many different conditions
    # Panel functions are be specified or customirzed to modify what is plotted in each panel.

# ggplot2 plotting system
  # it is a package in R 
    install.packages("ggplot2")
  # "Third" graphics system fo R along with base and lattice
  
  # qplot() #################
  # the basics: qplot()
    # works much like 'plot' function in base graphics system
    # looks for data in a data frame *
    # plots are made up of aesthetics (size, shape, color) and geoms (points,lines)
    # Factors are important as it indicates the subset of your data
      # ggplot() is the core function for doing things qplot() can't do
      
    # example:
      library(ggplot2)
      str(mpg) 
      qplot(displ,hwy,data=mpg)
        # qplot input --> (x-coordinate, y-coordinate, data frame)
      qplot(displ,hwy,data=mpg,col=drv) # specify color according to drv
      qplot(displ,hwy,data=mpg,geom=c("point","smooth")) # add the point and add the smooth line with 95% CI
      qplot(hwy,data = mpg,fill=drv) # get histogram and filled with different color
      # Facets: similar to panel in lattice
        # subset the plot
        qplot(displ,hwy,data = mpg,facets = .~drv) # drv indicate how many columns
          # left of the tilder '~' indicate how many rows
          # since we don't specify we put a dot '.'
        qplot(displ,hwy,data = mpg,facets = drv~.)
      # scatter plots (more):
        qplot(displ,hwy,data=mpg,col=drv) + geom_smooth(method = "lm")
          # to look at linear relationship
  # Basic componetns of ggplot:
    # a data frame
    # aesthetic mappings: how data are mapped to color or size
    # geoms: geometric objects like points, lines, shapes
    # facets: for conditional plots
    # stats: statistical transformations like binning, quantiles and smoothing
    # scales: what scale an aesthetic map uses
    # coordinate system
  # plots are built up in layers:
        # plot the data
        # overlay a summary
        # annotation
  qplot(displ,hwy,data=mpg, facets = .~drv, geom=c("point","smooth"))
 # restuct the plot using ggplot:
  g <- ggplot(data = mpg,aes(displ,hwy))
  summary(g) # aesthetic mapping
  print(g) # no layers in plot yet
  p <- g + geom_point()
  print(p) # add the point
     # you can also:
        g+geom_point() # to auto print the plot
  g + geom_point() + geom_smooth() 
  g + geom_point() + geom_smooth(method = "lm") #linear regression line
  # adding facet:
  g + geom_point() + geom_smooth(method = "lm") + facet_grid(.~drv)
  
  # Annotation:
    g + geom_point(color = "steelblue",size=4,alpha=1/2)
      # alpha is the transparency
    # set color to according to the data variable;
      g + geom_point(aes(color=drv),size=4,alpha=1/2)
    # add title and labels
      g + geom_point(aes(color=drv),size=4,alpha=1/2) + labs(title="Hello") + labs(x="xaxis", y= "yaxis")
    # customize more  
      g + geom_smooth(size=4,linetype=3,method="lm",se=FALSE) + geom_point(aes(color=drv),size=4,alpha=1/2) + labs(title="Hello") + labs(x="xaxis", y= "yaxis")
       # SE = false to remove 95% CI gray area
    # change the overall theme:
      g + theme_bw(base_family = "Times") + geom_smooth(size=4,linetype=3,method="lm",se=FALSE) + geom_point(aes(color=drv),size=4,alpha=1/2) + labs(title="Hello") + labs(x="xaxis", y= "yaxis")
      