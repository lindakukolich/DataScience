## Background
Installing R, Rstudio, GitHub, which I've already done, so I skipped those lectures.

## Week 1 - R Nuts and Bolts
Though not actually. This is not tiny details but an overview of R, skipping the cool packages that make it useful for actual Data Science work (Graphing and Machine Learning)

### History of R
- R an upgrade of S
  - Fortran libraries for Statistical Modeling.
  - Rewritten in C in 1988
  - Statistical Models in S by Chambers and Hastie (the white book)
  - Version 4 of S in 1998 Programming with Data by Chambers
  - There was a big list of companies that had the development license for S, StatSci, ATT, Lucent
  - The language hasn't changed much since 1998
- S Philosophy
  - Work in an interactive environment
  - Gradually slide into programming
- R starts in 1991 with Ihaka and Gentleman from New Zealand, U of Auckland
  - 1995 under GNU GPL
  - R-help and R-devel mailing lists
  - 1997 R Core Group formed, changes must be passed through them
- R Pros and Cons
  - Pros
    - Similar to S (best in the transition time)
    - Under active development
    - Lean software with lots of modules
    - Very good graphics
    - interactive plus programming interface
    - active user groups
    - Free (you do not have to pay)
    - Free (no restrictions on how it works)
    - Free (can read source to modify it for your needs)
    - Free (can redistribute)
    - Free (can improve and release your improvements)
  - Cons
    - Based on 40 year old tech
    - Little built in support for 3-D or dynamic graphics
    - Functionality is based on consumer demand (if you want it and it isn't there, it is your job to add it)
    - objects must be stored in physical memory (some advancements to deal with this)
  - Design
    - Base system
      - utils, stats, datasets, graphics, grDevices, grid, methods, tools, parallel, compiler, splines, tcltk, stats4
    - Modules
      - boot, class, cluster, codetools, foreign, KernSmooth, lattics, mgcv, nlme, rpart, survival, MASS, spatial, nnet, Matrix, ...
      - 4000 packages on CRAN
      - other packages on http://bioconductor.org>Bioconductor
      - packages on personal websites
### Getting Help
This was largely a repetition of the getting help lecture from Toolkit
### R Basics
- Objects
  - Atomics
    - character
    - numeric (float/double)
      - Inf is a number
      - NaN is a non-number
    - integer
      - 1L is int, 1 is numeric
    - complex
    - logical (bool)
  - Basic
    - vector
      - all objects share class
    - list
      - looks like a vector
      - classes can be different
    - vector() generates an empty vector
  - Attributes
    - names, dimnames
    - dimensions (matrices, arrays)
    - class
    - length
    - user-defined metadata
    - attributes() allows you to set attributes of an object
  - Operators
    - Assignment
```
x <- 1 # make a numeric vector, length 1, with 1 in the first element
print x
[1] 1
# Comment
# Make a range
x <- 1:20 # make a numeric vector, with the range 1,2,...,20 in it
x  # autoprint x
[1] 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 # first element on this line is number 1
[16] 16 17 18 19 20 # first element on this line is number 16
## use c() to concatenate objects to make a vector
x <- c("a", "b", "c")
x <- x(1+0i, 2+4i)
## use vector()
x <- vector("numeric", length=10)  # 10 default numerics, that is, 10
0s
## mixing objects - coercion, will not be an error, R will find lowest common denomenator
y <- c(1.7, "a") ## character: "1.7", "a"
y <- c(TRUE, 2) ## numeric: 1, 2
y <- c("a", TRUE) ## character: "a", "TRUE"
## Use as.TYPE to do explicit coercion
x <- 0:6
class(x)
[1] "integer"
as.numeric(x)
[1] 0 1 2 3 4 5 6
as.logical(x)
[1] FALSE TRUE TRUE TRUE TRUE TRUE TRUE
as.character(x)
[1] "0" "1" "2" "3" "4" "5" "6"
## nonsensical coercion results in NA
as.numeric(c("a", "b", "c"))
NA NA NA
## Matrices
m <- matrix(nrow = 2, ncol = 3)
dim(m)
attributes(m)
# matrices are filled column-wise
m <- matrix(1:6, nrow = 2, ncol = 3)
    [,1] [,2] [,3]
[1,]  1     3    5
[2,]  2     4    6
```
- Matrices
  - cbind - column bind
  - rbind - row bind
- Lists
  - types can change. Probably how we do classes (structs), but using 1980s tech
  x <- list(1, "a", TRUE, 1 + 4i)
- Factors
  - represent categorical data
  - unordered (male, female)
  - ordered (assistant, associate, full, senior staff)
  - treated specially by lm() and glm(), which fit linear functions
  - factors let us use names (male and female) rather 1 and 2
  - factor()
    - input is a character vector
    - returns vector and levels (male female)
    - option levels = c ("yes", "no")
  - table(x)
    - gives counts of each "level"
    - default level order is alphabetical
- is.na(), is.nan()
  - NA means it is missing
```
x <- c(1, 2, NaN, NA, 4)
is.na(x)
[1] FALSE FALSE TRUE TRUE FALSE
is nan(x)
[1] FALSE FALSE TRUE FALSE FALSE
```
- Data Frame
  - stores tabular data
  - list of lists, where each sublist has the same length
  - attribute row.names to name each row
  - read.table() and read.csv() to generate
  - convert to a matrix data.matrix()
```
x <- data.frame(foo = 1:4, bar = c(T,T,F,F) rownames=c("one", "two", "three", "four"
x
   foo bar
one  1  TRUE
two  2  TRUE
three  3  FALSE
four  4  FALSE
```
- Names
  - name elements in a vector
  x <- 1:3
  names(x) <- c("foo", "bar", "norf")
  x
    foo bar norf
     1   2   3
  - can name lists
  x <- list(a = 1, b = 2, c = 3)
  - can name matrices
```
m <- matrix(1:4, nrow = 2, ncol = 2)
dimnames(m) <- list (c("a", "b"), c("c", "d"))
```
### Subsetting objects
- single square [ bracket returns a list of objects
- double bracket [[ returns a single element
- dollarsign $ extracts elements by name
- example
```
x <- c("a, "b", "c", "c", "d", "a")
x[1]
[1] "a"
x[2]
[1] "b"
x[1:4]
[1] "a" "b" "c" "c"
x[x > "a"]
[1] "b" "c" "c" "d"
u <- x > "a"
u
[1] FALSE TRUE TRUE TRUE TRUE FALSE
x[u]
[1] "b" "c" "c" "d"
```
- matrices
  - matrix elements are taken with [row, col]
  - elements can be missing to take a row [1,] or column [,2]
  - drop can be set to FALSE to keep the system from dropping the dimensions, so you can get a 1x1 matrix with an element in it, rather than a vector length 1
- list
  - can use single or double brackets. Single bracket returns a list from a list, double returns just the elements instead of the elements with the name? Not clear.
  - can use named elements within the brackets x[[$bar]]
  - can also do x$bar
- double bracket can work with computed indices
```
x <- list(foo = 1:4, bar = 0.5, baz = "hello")
name <- "foo"
x[[name]]
[1] 1 2 3 4
x$name  # Element 'name' does not exist
NULL
```
- double bracket can take an integer sequence, to extract multiple elements
- partial matching
```
x <- list(aardvark = 1:5)
x$a # partial match
x[["a"]] # No element named "a"
NULL
x[["a", exact = FALSE]] # partial match
```
- common task is to remove missing values (NAs)
  - is.na() to give a vector of logicals for which values are missing
  - complete.cases() to extract elements with no missing values
### Vectorized Operations
- Unary Operators automatically work on elements of a vector
- Binary operators automatically work on  pairs of elements in pairs of vectors
- default operator is element-wise on matrix
- %*% to do true matrix multiplication
### Reading data
- Overview
  - read.table, read.csv (Read tablular data) write.table
  - readLines (read lines of a text file) writeLines
  - source (read R code files) dump
  - dget (read R code files) dput
  - load (read saved workspaces) save
  - unserialize (read binary object) serialize
- read.table
  - file
    - name of file
  - header
    - logical indicating if the file has a header line
  - sep
    - separator for columns
    - default is space
    - default is comma for read.csv
  - colClasses
    - class (Type) of each column in dataset
    - can be figured out automatically, but that takes time with large datasets
    - read the first few rows to get the classes
```
initial <- read.table("datatable.txt", nrows = 100)
classes <- sapply(initial, class)
tabAll <- read.table("datatable.txt", colClasses = classes)
```
- nrows
  - number of rows in dataset
  - can be figured out automatically, but that takes time with large datasets
  - use wc to make sure you only allocate as much space as you need
- comment.char
  - comment character in file
  - default #
  - set to "" if there are no commented lines, to save time
- skip
  - skip rows of non-data in head of file
- stringsAsFactors
  - logical should character variables be factors?
- Memory concerns
  - How much RAM do you have?
  - what other apps are running
  - what OS
  - is this 32 or 64 bit?
  - example
    - 1,500,000 rows, 120 columns, all numeric
    - 1.5e6 * 120 * 8bytes/numeric
    - 1.44e9 / (2^30) Gbytes
    - 1.34 GB
- Other Text formats
  - dump, dput
  - preserve metadata (types for instance) so you do not have to keep figuring it out
  - plays nice with version control systems
  - more robust to corruption
  - takes up more space
  - dput/dget works with a single object
  - dump, source works with multiple objects
- connections open files or compressed files or web pages
  - file, gzfile, bzfile, url
  - connections are good for reading parts of a file, rather than reading a whole file

### Swirl
- Interactive R environment
- worth extra credit
- Cool Commands
  - seq_along(VECTOR)
    - generates a sequence of numbers, 1:length(VECTOR)
    - also equivalent to seq(along.with = VECTOR)
  - rep(value, times = 10)
    - repeat value 10 times, where value is a number or a vector
  - rep(c(0, 1, 2), times = 3)
    - 0 1 2 0 1 2 0 1 2
  - rep(c(0, 1, 2), each=3)
    - repeat each element of value 3 times
    - 0 0 0 1 1 1 2 2 2
  - paste(VECTOR_OF_STRINGS, collapse = " ")
    - concatenate the elements of the vector together, using " " as the field separator
    - sep=" " seems to do about the same thing as collapse. What is the difference?
  - rnorm(NUMBER)
    - generate NUMBER draws from a standard normal distribution (0 mean, unit variance?)
  - sample(VECTOR, NUMBER)
    - sample the elements of VECTOR, selecting NUMBER of them (without replacement)
  - x[c(-2, -10)] OR x[-c(2, 10)]
    - return a subset of X including everything BUT the 2nd and 10th entries
  - a & b versus &&
    - & uses recycling to repeat either a or b to give the same lengths, and then tests a[1] && b[1], a[2] && b[2], etc. That is, & is the vectorized version
    - && tests just the first element of a against the first element of b
  - && is evaluated before ||
  - xor(), since there seems to be no xor operator
  - which(ints < 2)
    - return the indices of the elements in the vector ints that are less than 2
  - any() return whether any elements in the vector are TRUE
  - all() return whether all elements in the vector are TRUE

## Week 2 - Programming with R

### Control Structures
- if/else if/else
```
if(<condition>) {
 ## do something
} else if (<condition2>) {
  ## do something else
} else {
  ## Do a default thing
}
y <- if(x < 10) {
  0
} else {
  10
}
  - for
 for(i in VECTOR) {
   print(i)
}
```
- seq_along(VECTOR) generates a vector 1:length(x)
- while
```
while (z >= 3 && z <= 10) {
  print (z)
  coin <- rbinom(1, 1, 0.5)
  if (coin == 1) { z <- z + 1 }
  else {z <- z - 1 }
}
```
- repeat
  - an infinite loop
  - use break to leave the loop
- next
  - skip the rest of the loop and start with the next iterator
- return
  - return from a function, which also does a break
- apply
  - better when in interactive environment, will discuss later

### Functions
Put them in their own files. We will eventually put them in R
packages, but that is for later. The code can be editted within
RStudio.

```
# return the sum of x and y
add2 <- function(x, y) {
  x + y
}
# return elements of x that are greater than n, which has a default value
above <- function(x, n = 10) {
  use <- x > n
  x[use]
}
```
Functions can be passed as arguments and function calls can be
nested.

There are formal argument and named arguments. Some functions can be
missing or might have default values. You can name arguments in their
calls. There seems to be nothing special about this, the names are
just the names you gave the arguments in the declaration.

He then went into lots of rules about when you can get sloppy about
which arguments you set and how to figure out which arguments get
assigned to what when you call a function. Basically, everything is
positional, unless it is named. Having a named argument takes it out
of the positional list and the rest of the arguments are assigned
positionally to the remaining unnamed argument spots. You can use
partial matching to name arguments. You can have ... as an
argument. Pretty much you can do nearly anything, which of course will
get you into trouble, but allow lazyness seems to be the watchword for
this language, since it is supposed to get things done, not be formal.

### Scoping
If a function sees a symbol in the body, how does it know what the
value is? Check global, and then check packages in a certain order. You
can play with the package search order. 

Lexical scoping. Symbols are found where the function was defined, not
the call stack. Basically, an old solution to the need to define
proper classes with private class variables.

### Dates and Times
- Date class
  - Number of days since 1970-01-01
- POSIXct and POSIXlt class
  - Number of seconds since 1970-01-01
  - POSIXct is a very large integer
  - POSIXlt is a list with precalculated stored stuff, like day of year, day of week.
```
d <-as.Date("1970-01-01")
unclass(date)  # gives the integer this is this day number
# Most of the work seems to be 
x <- Sys.time()
weekdays(x)   # weekday name?
months(x)     # month name
quarters(x)   #Q1 Q2 Q3 Q4
p <- as.POSIXlt(x)
names(unclass(p))
## [1] "sec" "min" "hour" "mday" "mon"
## [6] "year" "wday" "yday" "isdst"
datestring c("January 10, 2012 10:40", "December 9, 2011 9:10")
x <- strptime(datestring, "%B %d %Y %H:%M")
?strptime # print details
```
A lot of plotting functions recognize date and time objects and react
appropriately.

## Looping on the command line

## lapply and sapply
Loop over a list and evaluate the given function on each
element. lapply returns a list. sapply attempts to simplify the
resulting list to a simpler data structure (like a vector)

lapply(list, func, ...)

sample functions he showed us
- mean

- runif - random uniform. generates the requested number of uniform
random entries
  - lapply(1:4, runif, min = 0, max = 10)

Can also use anonymous functions

x <- list(a = matrix(1:4, 2, 2), b = matrix(1:6, 3, 2))
# extract the first column from each input matrix
lapply(x, function(elt) elt[,1])

sapply(list, func, ...)
For mean, this will return a vector, since each list that is returned
has length 1 and the conversion works. For elt or runif, a list will
be returned, since the elements of the return lists have different
lengths.

## apply
    x <- matrix(rnorm(200), 20, 10)
    # give a mean for each column
    # the 2 means keep the second dimension, the columns, collapse the first
    # dimension, the rows
    apply(x, 2, mean)
    # give a sum of each row
    # 1 means keep the row, so therefore collapse the columns
    apply(x, 1, sum)

    rowSums = apply(x, 1, sum)
    rowMeans = apply(x, 1, mean)
    colSums = apply(x, 2, sum)
    colMeans = apply(x, 2, sum)

quantiles of rows of a matrix

calculate the mean and variance and return the 25% and 75% quantiles
    for a distribution modeled by the mean and variance from each row
    apply(x, 1, quantile, probs = c(0.25, 0.75))

## mapply
multivariate version
function (FUN, ..., MoreArgs = NULL, SIMPLIFY = TRUE, USE.NAMES =
TRUE)

    list(rep(1, 4), rep(2, 3), rep(3, 2), rep(4,1))
    #instead do
    mapply(rep, 1:4, 4:1)

Give elements of lists as arguments to FUN, matching them as we go. It
can be a way to vectorize functions that are not naturally vectorized.

mapply(noise, 1:5, 1:5, 2) is the same as list(noise(1, 1, 2),
noise(2, 2, 2), noise(3, 3, 2), noise(4, 4, 2), noise(5, 5, 2)).

## tapply
applies function over a subset of a vector
    tapply <- function(X, INDEX, FUN = NULL, ..., simplify = TRUE)
    X is a vector
    INDEX is a factor or a list of factors (or else they are coerced
    to factors
    FUN is a function to be applied
    ... contains other arguments to be passed to FUN
    simplify, should we simplify the result?

    ## generate 10 samples from each of 3 distributions   
    x <- c(rnorm(10), runif(10), rnorm(10, 1))
    ## generate 3 levels, 10 of each type. that is, 10 1s, 10 2s, 10 3s
    f <- gl(3, 10)
    ## generate means for each of the 3 distributions
    tapply(x, f, mean)
    ## this returns a vector of 3 numbers, the means of the 3
    ## distributions, calculated using the correct subsets of x as
    ## described by f

## split
Divides a vector into pieces as specified by the factor given (factors
are levels in a groupd)

    split <- function(x, f, drop = FALSE, ...)
    x is a vector
    f is a list of factors
    drop empty levels

He gives an example from the airquality data frame.
To calculate the mean of Ozone, Solar.R, Wind for each month
    s <- split(airquality, airquality$Month
    lapply(s, function(x) colMeans(x[, c("Ozone", "Solar.R",
    "Wind")]))
    $'5'
     Ozone Solar.R Wind
       NA    NA    11.62258
    $'6'
     Ozone Solar.R Wind
     NA    190.16667 10.26667
Simplifying and taking out the NA entries we get
    sapply(s, function(x) colMeans(x[, c("Ozone", "Solar.R", "Wind")],
        na.rm = TRUE))
                 5         6         7        8       9
    Ozone    23.6       29.4      59.1
    Solar.R   181,3
    Wind      11.6      etc.

Splitting on more than one level, so M,F and age ranges
interaction() function gives levels like 1.1 1.2 2.1 2.2

    str(split(x, list(gl(2, 5), gl(5, 2)), drop = TRUE))

## Debugging
- message a generic notification/diagnostic message produced by the
message function; the function continues
- warning - an indication that something is wrong but not necessary
fatal; execution of the function conditions; generated by the warning function
- error - indication that a fatal problem has occurred; execution
stops; produced by the stop function
- condition - a generic concept for indicating that something
unexpected can occur; programmers can create their own
conditions. Each of these message are "conditions"

try log(-1). We get a warning.

invisible(x) prevent automatic printing of the return object of a
function. 

How do you know that something is wrong with your function?
- What was your input? How did you call the function
- What were you expecting? Output, messages, other results?
- What did you get?
- How does what you get differ from what you were expecting?
- Were your expectations correct in the first place?
- Can you reproduce the problem (exactly)?

### Debugging tools in R
- traceback
  -  prints out the function call stack after an error occurs
  - does nothing if there is no error
  - useful when asking others for help
  - gives the trace from the most recently called function
- debug
  - flags a function for "debug" mode
  - allows you to step through execution of a function line by line
  - shows current environment
- browser: suspends the execution of a function whereever it is called
and puts the function in debug mode
- trace: allows you to insert debugging code into a function at
specific places
- recover: allows you to modify the error behavior so you can browse
the function call stack.

## Cool commands for quiz
- subset(iris,Species=='virginica')

## str function
Print the internals of an object or function, printed compactly.
    x <- rnorm(100, 2, 4)
    str(x)
    num [1:100] 7.299 -4.668 -5.245
    f <- fl(40, 10)
    str(f)
    Factor w/ 40 levels "1","2",..: 1 1 1 1 ...
    str(airquality)
    'data.frame': 153 obs. of 6 variables:
    $ Ozone  : int 41 36 12 18 ...
    $ Solar.R: int 190 118 139 313 ...
    ...
   s <- split(airquality, airquality$Month)
   str(s)
   List of 5
   $ 5:'data.frame': 31 obs. of 6 varibles:
   ...
   $ 9:'data.frame': 30 obs. of 6 variables:
   ..$Ozone  : int [1:30] 96 78
   ...

## Simulation (Distributions)

- functions
  - d for density
  - r form random number generation
  - p for cumulative distribution (Pr(x <= X) pnorm(X, mean=m, sd=s))
  - q for quantile function
- Distributions
  - norm
    - mean
    - sd
    - log
    - lower.tail
  - pois
    - mean is equal to the rate
  - gamma
  - binom
- set.seed() so that results are repeatable

## Simulation from a model

### Normal distribution
If we have a model, y = B0 + B1x + e
Where e is a number with a normal distribution, standard deviation 2
(e &tilde; N(0,2^2)., B0 = 0.5, B1 = 2, x &tilde; N(0, 1^2)
    set.seed(20)
    x <- rnorm(100)
    e <- rnomr(100, 0, 2)
    y <- 0.5 + 2 * x + e
    summary(y)
    plot(x, y)

### Binary distribution
What if x is binary?
    x <- rbinom(100, 1, 0.5)
    e <- rnomr(100, 0, 2)
    y <- 0.5 + 2 * x + e

### Poisson Distribution
Simulating a Poisson Distribution
Y &tilde; Poisson(mu)
log muy = B0 + B1x
and B0 = 0.5 and B1 = 0.3.
    set.seed(1)
    x <- rnorm(100)
    log.mu <- 0.5 + 0.3 + x
    y <- rpois(100, exp(log.mu))

### Random sampling
    set.seed(1)
    sample(1:10, 4)
    sample(1:10, replace=TRUE)

## Profiler
Where is the computer spending its time? Is it possible to make the
code run faster so I don't have to wait as long to get things done?

system.time(), user time versus elapsed time

Elapsed time can be longer, if you are say asking for a web resource
and are waiting for the web to respond. If, instead, you are doing
math and have a multi-core system and have a library that uses those
cores, the elapsed time can be SHORTER than the user time.

## RProf()
- Must be compiled in.
- summaryRprof() summarizes the output from Rprof()
- Does not play nice with system.time()
- returns the call stack, which is not totally helpful
- summaryRprof()
  - by.total
    - divides the time spent in each function by the total run time
    -  tells you something like how often the function is called.
  - by.self
    - How much time is spent here, subtracting out the lower functions
    that this one calls
  - sample.interval
  - sampling.time

