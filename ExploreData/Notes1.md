# Principles of Analytic Graphics #

Taken from *Beautiful Evidence* by Edward Tufte (2006)

1. Show comparisons
    * Evidence for a hypothesis is always relative to another competing
	hypothesis
    * Always ask "Compared to What?"
	* Example: Do not just show Symptom-free Days with air cleaner,
      but also add Symptom-free Days without one.
2. Show causality, mechanism, explanation, systematic structure
    * What is your causal framework for thinking about a question?
	* Show levels of particulate matter before and after, to give a
      possible explanation
3. Show multivariate data
	* Multivariate = more than 2 variables
	* air pollution versus mortality, across seasons. When all the
      data is pooled, mortality goes down with pollution. When each
      season is separated, mortality goes up with pollution within
      each season.
	* Need to escape flatland
4. Integration of evidence
	* Completely integrate words, numbers, images, diagrams
	* Data graphics should make use of many modes of data presentation
	* Don't let the tool drive the analysis
	* Example gives course particulate matter and hospitalizations. It
      combines two columns of text and one graphic, so a table with a
      set of plots as one of the columns that keeps the numbers and
      the image together nicely
5. Describe and document the evidence with appropriate labels, scales, sources,
	etc.
	* A data graphic should tell a complete story that is credible
6. Content is king
    * Analytical presentations untimately stand or fall depending on the
    quality, relevance, and integrity of their content

# Exploratory Graphs #

## Why do we use graphs in data analysis? ##

* Exploration
    * To understand data properties
	* To find patterns in data
	* To suggest modeling strategies
	* To "debug" analyses
* Communication
    * To communicate results

## Characteristics of an exploratory graph ##
* They are made quickly
* A large number are made
* The goal is for personal understanding
* Axes/legends are generally cleaned up later
* Color/size are primarily used for information

## Data Summaries ##
Our data is annual average PM2.5 (fine particle pollution) averaged
over the period 2008 - 2010. Do any counties in the US exceed the
standard of 12 micrograms/cubic-meter?

The data has 5 columns
* pm25 - fine particle pollution
* fips - ?
* region - east or west
* latitude
* longitude

* Five-number summary
    * `summary(pollution$pm25)`
    * gives the max of 18, so at least one does
* Boxplots
    * `boxplot(pollution$pm25, col = "blue")`
    * `abline(h = 12)`
    * Shows several outliers above 15, so yes
* Histograms
    * `hist(pollution$pm25, col = "green")` add `breaks=100` to make
      it finer grain, at the risk of adding too much noise
    * `rug(pollution$pm25)` - plot all points below data
	* `abline(v = 12, lwd = 2)`
	* `abline(v = median(pollution$pm25), col = "magenta", lwd = 4)`
    * There are histogram bins above 12 that are not empty, so yes
* Density plot
	* Not shown
* Barplot
	* Gave us an example working with east and west,
      setting up for the 2D work coming up
    * `barplot(table(pollution$region), col = "wheat", main = "Number of Counties in Each Region")`

## Simple 2D summaries of data ##

Multiple/overlayed 1-D plots (lattice/ggplot2)

	boxplot(pm25 ~ region, data = pollution, col = "red")
    par(mfrow = c(2, 1), mar = c(4, 4, 2, 1))
    hist(subset(pollution, region == "east")$pm25, col = "green")
    hist(subset(pollution, region == "west")$pm25, col = "green")
	
Scatterplots. In both each and west, being farther north does
something.

    with(pollution, plot(latitude, pm25, col = region))
	abline(h = 12, lwd = 2, lty = 2)
	par(mfrow = c(1, 2), mar = c(5, 4, 2, 1)
    with(subset(pollution, region == "west"), plot(latitude, pm25, main = "West"))
    with(subset(pollution, region == "east"), plot(latitude, pm25, main = "East"))

* Smooth scatter plots
* Overlayed/multiple 2-D plots; coplots
* Use color, size, shape to add dimensions
* Spinning plots
* Actual 3-D plots (not that useful)

## Summary ##

* Exploratory plots are "quick and dirty"
* Let you summarize the data (usually graphicaly) and highlight any broad
features
* Explore basic questions and hypotheses (and perhaps rule them out)
* Suggest modeling strategies for the "next step"

# Plotting Systems in R #

There are three plotting systems in R. They cannot be mixed together
to build a combined plot. You have to figure out how to build what you
want within one plotting system.

## Base Plotting System ##

* Cannot go back to adjust things after the plot has been started
* A series of R commands, so put it in a script to do those
"adjustments"
* Each aspect of the plot is handled separately though a
series of function calls. This allows plotting to mirror the thought
process. (a plot of values) with (multiple) (additional) (annotations)
* For exploration with display on the screen, this is an appropriate
package for us to use.
* It is hard to describe to a person what it is you have plotted. All
  you have is a pile of R commands which, if they run then, can SHOW
  what you meant, but not tell it. See the layout, par pile-up at the
  end of this document for an example. Without lots of comments about
  what each unintelligble part does, no one will guess at the result
  by reading the code.

Example

	library(datasets)
	data(cars)
	with(cars, plot(speed, dist))

## Lattice System ##
* Plots are created with a single function call (xyplot, bwplot, etc)
* Most useful for conditioning types of plots: Looking at how y
  changes with x across levels of z
* Things like margins/spacing set automatically because entire plot is
specified at once
* Called a **Panel Plot**
* Good for putting many many plots on a screen
* Sometimes awkward to specify an entire plot in a single function
  call
* Annotation in plot is not especially intuitive
* Use of panel functions an subscripts difficult to wield and requires
intense preparation
* Cannot "add" to the plot once it is created

Example

    library(lattice)
	state <- data.frame(state.x77, region = state.region)
	xyplot(Life.Exp ~ Income | region, data = state, layout = c(4, 1))

## The ggplot2 System ##

* GG - Grammar of Graphics
* Splits the difference between base and lattice in a number of ways
* Automatically deals with spacings, text, titles, but also allows you to
annotate by "adding" to a plot
* Superficial similarity to lattice but generally easier/more intuitive to use
* Default mode makes many choices for you (but you can still customize
to your heart's desire
* Independently implemented, not based on either base or lattice

Example
	library(ggplot2)
	data(mpg)
	qplot(displ, hwy, data = mpg)

## Process of Plotting ##

Questions to ask yourself when choosing tools

* Where will the plot be made, on the screen or in a file?
* How will the plot be used?
	* Is the plot for viewing temporarilty on the screen?
	* Will it be presented in a web browser?
	* Will it eventually end up in a paper that might be printed?
	* Are you using it in a presentation?
* Is there a large amount of data going into the plot, or is it just a
few points?
* Do you need to be able to dynamically resize the graphic?

## Pieces of R Plotting Support ##

* *graphics:* contains plotting functions for the "base" graphing
systems `plot, hist, boxplot`, etc.
* *grDevices:* contains all the code implementing the various graphics
devices (for storing in files) PostScript, PNG, etc.

Lattice plotting can be implemented using either:

* *lattice:* contains code for producing Trellis graphics, with plots
independent of the base plots, `xyplot, bwplot, levelplot`
* *grid:* lattice is built on to of grid and we rarely use it **So why
tell us about it here?**
* *layout* and *par("mfrow"):* There is a command, layout, that allows
  tiling of plots generated using the base plotting package. Putting
  proper titles in is a bear resulting in very opaque code. On the
  other hand, you CAN generate "lattice" style plots with the base
  system. You can also do some basic multi-plot layout using the
  `mfrow` or the `mfcol` parameter.

## Base Plotting ##
* `?par` shows parameters available to set values on a base plot. *Set
or Query Graphical Parameters*. Categories of parameters:
* margin specification and plot borders
* text placement, size, and font
* colors of text, borders, axes
* axes limits and tick mark locations
* Stuff I didn't notice in this scan of the help page
* parameters held up by the lecturer
    * `las`: orientation of the axis labels on the plot
	* `bg`: background color
	* `mar`: margin size
	* `oma`: outer margin size
	* `mfrow`: number of plots per row, column (plots are filled
    row-wise)
	* `mfcol`: number of plots per column, row (plots are filled in
    column-wise)
* par("PARAMETER_NAME") to have the current value of the parameter
printed
* par(PARAMETER_NAME=value) to set the value of a parameter


## Plot commands ##

* `hist` - histogram plot
* `plot` - scatter plot, or other plot depending on the class of the input
* `boxplot` - like a scatter plot with a box to hold most of the data
  and individual points for outliers
* `lines` - add lines to a plot
* `points` - add points to a plot
* `text` - add text labels to a plot at x,y coordinates
* `title` - add annotations. There are parameters for lots of places
  you might want labels, like x-axis, outer margin, main title,
  sub-title
* `mtext` - add margin text
* `axis` - add axis ticks and labels
* `legend` - add a box labeling subsets of points

## Base Graphics Parameters ##

* `pch`: the plotting symbol (default is open circle)
	* `example(points)` gives examples of stuff you can do with
      plotting symbols
* `lty`: the line type (default is solid line)
* `lwd`: the line width - you can use thinner lines in publications
  than on viewgraphs
* `col`: plotting color, specified as number, string, or hex code
* `xlab`: x-axis label
* `ylab`: y-axis label


A scatter plot of points, Wind versus Ozone. Some are red and some are
blue and there is a legend telling which are which in the upper right
corner of the plot.

	# set the sizes of the plot, plotting all the data but not showing
    # any of it
    with(airquality, plot(Wind, Ozone, main = "Ozone and Wind in
	NewYork City", type = "n"))
	# add May points
	with(subset(airquality, Month == 5), points(Wind, Ozone, col =
	"blue"))
	# add not-May points
	with(subset(airquality, Month != 5), points(Wind, Ozone, col =
	"red"))
	# add a legend to label points
	legend("topright", pch = 1, col = (c("blue", "red"), legend =
	c("May", "Other Months")))

A scatter plot of points, Wind versus Ozone, with a line running
through giving a linear model of their relationship

	with(airquality, plot(Wind, Ozone, main = "Ozone and Wind in New
	York City", pch = 20))
	model <- lm(Ozone ~ Wind, airquality)
	abline(model, lwd = 2)

Three plots, Wind versus Ozone and Solar.R versus Ozone, Temperature
versus Ozone, lined up side by side

	par(mfrow = c(1, 3), mar = c(4, 4, 2, 1), oma = c(0, 0, 2, 0))
	with(airquality, {
		plot(Wind, Oone, main = "Ozone and Wind")
		plot(Solar.R, Ozone, main = "Ozone and Solar Radiation")
		plot(Temp, Ozone, main = "Ozone and Temperature")
		mtext("Ozone and Weather in New York City", outer = TRUE)
	})

I wonder how you would add trend lines to all three of these? An
answer given on StackOverflow gives the `layout` command to control
the overall placement of things and then add text annotation. Not
quite it. I did come across `plotmath` that allows you to use Latex
expressions in plot labels.

It looks like I COULD have done the plot above as:

    par(mfrow = c(1, 3), mar = c(4, 4, 2, 1), oma = c(0, 0, 2, 0))
	title(main = "Ozone and Weather in New York City")
	with(airquality, plot(Wind, Ozone, main = "Ozone and Wind"))
	model <- lm(Ozone ~ Wind, airquality)
	abline(model, lwd = 2)
	with(airquality, plot(Solar.R, Ozone, main = "Ozone and Solar Radiation"))
	model <- lm(Ozone ~ Solar.R, airquality)
	abline(model, lwd = 2)
	with(airquality, plot(Temp, Ozone, main = "Ozone and Temperature"))
	model <- lm(Ozone ~ Temp, airquality)
	abline(model, lwd = 2)

Which gives me my trend lines, but misses the title. This is pretty
close to what they had plus what I want, which will do for now

    layout(matrix(c(1, 1, 1, 2, 3, 4, ncol = 3, byrow = TRUE)),
    	heights = c(0.05), .95)
	par(mar = c(0, 0, 0, 0)
	plot(1, 1, type = "n", frame.plot = FALSE< axes = FALSE
	u < par("usr")
	text(1, u[4], labels = "Ozone and Weather in New York City", pos =
	1)
	par(mar = c(2, 4, 4, 2))
	# and then the rest of the plots

Going at it from the other direction also works. It is the with
command that is messing with my head here.

	owModel <- lm(Ozone ~ Wind, airquality)
	osModel <- lm(Ozone ~ Solar.R, airquality)
	otModel <- lm(Ozone ~ Temp, airquality)
	par(mfrow = c(1, 3), mar = c(4, 4, 2, 1), oma = c(0, 0, 2, 0))
	with(airquality, {
	    plot(Wind, Ozone, main = "Ozone and Wind")
	    abline(owModel, lwd=2)
		plot(Solar.R, Ozone, main = "Ozone and Solar Radiation")
	    abline(osModel, lwd=2)
		plot(Temp, Ozone, main = "Ozone and Temperature")
	    abline(otModel, lwd=2)
		mtext("Ozone and Weather in New York City", outer = TRUE)
	})

Using `with` makes the axis labels prettier. With the $ notation, the
$ part shows up in the labels and spoils things

# Graphics Devices in R #

A graphics device is something where you can make a plot appear.

* `?Devices` gives a list of devices. There are more devices created
  by users on CRAN
* screen device - A window on your computer
* file device
    * graphics files
	    * pdf
        	* good for line-type graphics
        	* resizes well
			* usually portable
			* not good when there are lots of points
		* svg
			* XML-based scalable vector graphics
			* supports animation and interactivity
			* nice for web based plots
		* win.metafile
			* windows only
		* postscript
			* older format
			* resizes well
			* usually portable
			* makes encapsulated postscript
			* Windows systems often cannot display
    * bitmap file
		* png
			* bitmapped
			* good for line drawings or images with solid colors
			* uses lossless compression
			* most browsers can read this
			* good for drawing many many points
			* does not resize well
		* jpeg
			* good for photos
			* uses lossy compression
			* good for plotting many many points
			* does not resize well
			* can be read by almost any computer and browser
			* not great for line drawings
		* tiff
			* supports lossless compression
		* bmp
			* a native Windows bitmapped format

## Plotting on Multiple Graphics Devices ##

You can have more than one graphics device open at a time, but only
one is active.

* `dev.list()` give all the open devices
* `dev.cur()` gives the number of the active graphics device. It will
  be an integer &ge; 2. 
* `dev.set()` sets the active graphics device.
* `dev.copy`, `dev.copy2pdf` copies a plot from one device to another
* `dev.off()` turns off all the graphics devices, or give it an
  integer to turn off a specific one.
