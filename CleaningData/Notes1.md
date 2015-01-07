# Getting and Cleaning Data #

Third course in Data Scientist specialization. Depends on Data
Scientist Toolbox and R Programming. In this course we will learn to
take in raw data, and process it via a script into tidy data, ready
for analysis and communication. Jeffrey Leek is the lecturer, so far.

# Motivation #

## Ideas in the Course ##

* Finding and extracting raw data
* Tidy data principles and how to make data tidy
* Practical implementation through a range of R packages

## Motivation ##
Data comes in nice forms, like complete Excel files, and messy forms,
like random looking gene sequences, or collections of Twitter
messages, or human readable medical records, or data bases like mySQL
or MongoDB, or web pages

# Data #

## Definition of Data ##

Data are values of qualitative or quantitative variables, belonging to
a set of items. - From the wikipedia article on Data.
The *set of items* is the population; the set of objects you are
interested in. The *variables* are a measurements or characteristic of
an item. *Qualitative* is a categorical value, like country or sex or
treatment. *Quantitative* is a numeric value, like height, weight, or
blood pressure.

* Raw data is
    * The original data
	* Often hard to use for data analyses
	* Process once and stored "tidy"
* Processed data
    * Data that is ready for analysis
    * Processing can include merging, subsetting, transforming, etc
	* There may be standards for processing
	* All steps should be recorded

## Components of a good data package ##
1. The raw data
2. A tidy data set
3. A code book describing each variable and its values in the tidy data set
4. An explicit and exact recipe you used to go from 1 to 2 and 3

## Raw data ##
* The strange binary file your measurement machine spits out
* The unformatted Excel file with 10 worksheets
* The complicated JSON data you got by scraping the Twitter API
* Hand entered numbers you collected
* It is raw if:
    * You have run no software on the data
    * Did not manipulate any of the numbers in the data
	* You did not remove any data from the data set
	* You did not summarize the data in any way

## Tidy data ##
1. Each variable you measure should be in one column
2. Each different observation of that variable should be in a
different row
3. There should be one table for each "kind" of variable
4. If you have multiple talbes, they should include a column in the
table that allows them to be linked.

Tips

* Include a row at the top of each file with variable names.
* Make variable names human readble: AgeAtDiagnosis instead of AgeDx
* In general data should be saved in one file per table.

## The code book ##
1. Information about the variables (including units) in the data set
not contained in the tidy data
2. Information about the summary choices you made
3. Information about the experimental study design you used

Tips

* A common format for this document is a Word/text file
* There should be a section called "Study design" that has a thorough
description of how you collected the data
* There must be a section called "Code book" that describes each
variable and its units

# Downloading files #

## Directory paths ##
In R, use getwd() to find out what directory (folder) you are
currently in and setwd() to change that directory. Directory paths can
absolute (start with "/" on a Mac or a Linux box) or relative (start
with [a-zA-Z]). "." is the current working directory. ".." is the
directory above the current directory. On a Windows box, use "\\"
instead of "/" to separate the directories in a file path. Oh, and it
probably starts with "C:" because you need to be compatible with 30
year old DOS boxes. Seriously.

## Creating a directory in R ##
`file.exists("directoryName")` will check to see if the directory exists
(`test -d directoryName` on the Linux command line)

`dir.create("directoryName")` will create a directory if it doesn't
exist (`mkdir directoryName` on the Linux command line)

While I am thinking of it, `getwd() == pwd` and `setwd() == cd`

## Downloading a file in R ##
`download.file()`
* Downloads a file from the internet
* Even if you could do this by hand, helps with reproducibility
* Important parameters are *url, destfile, method*
* Useful for downloading tab-delimited, csv, and other files

Example:

    fileUrl <- "https://data.baltimorecity.gov/api/views/dz54-2aru/rows.csv?accessType=DOWNLOAD"
    download.file(file.Url, destfile = "./data/cameras.csv", method = "curl")
    list.files("./data")
    dateDownloaded <- date()
    dateDownloaded

* If the url starts with http, you can use download.file()
* If the url starts with https on Windows, you may be ok
* If the url starts with https on Mac, you may need to set *method="curl"*
* If the file is big, this might take a while
* Be sure to record when you downloaded.

# Reading local files #

## read.table(), read.csv() ##
* This is the main function for reading data into R
* Flexible and robust but requires more parameters
* Reads the data into RAM - big data can cause problems
* Imprtant parameters
    * File
    * header
	* sep
	* row.names
	* nrows
* Related
	* read.csv()
	* read.csv2()

Example:
    cameraData <- read.table("./data/camera.csv", sep = ",", header = TRUE)
    head(cameraData)
    ##                    address  direction      street     crossStreet           intersection                      Location.1
    ## 1 S Caton Ave & Benson Ave        N/B   Caton Ave      Benson Ave Caton Ave & Benson Ave (39.2693779962, -76.6688285297)
    ## 2 S Caton Ave & Benson Ave        S/B   Caton Ave      Benson Ave Caton Ave & Benson Ave (39.2693779962, -76.6688285297)
    ## 3  The Alameda & E 33RD St        E/B The Alameda         33rd St The Alameda  & 33rd St (39.3285013141, -76.5953545714)

`read.csv(file)` is the same as calling `read.table(file, sep=",",
header=TRUE)`

Important paramters
* *quote* - you can tell R whether there are any quoted
values. `quote=""` means no quotes.
* *na.strings* - set the character or string that represents a missing
value. Can be a vector like c("NA", "Not Available")
* *nrows* - how many rows to read of the file
* *skip* - number of lines to skip before starting to read

One of the biggest headaches is quotation marks (' or ") placed in
data. Setting quote="" often resolves these issues.

## reading Excel, read.xlsx() {xlsx package} ##
    fileUrl <- "https://data.baltimorecity.gov/api/views/dz54-2aru/rows.xlsx?accessType=DOWNLOAD"
    download.file(file.Url, destfile = "./data/cameras.xlsx", method = "curl")
    dateDownloaded <- date()
    library(xlsx)
    cameraData <- read.xlsx("./data/cameras.xlsx", sheetIndex=1, header=TRUE)

This reads in the same table as above

    colIndex <- 2:3
    rowIndex <- 1:4
    cameraDataSubset <- read.xlsx("./data/cameras.xlsx", sheetIndex=1,
    colIndex=colIndex, rowIndex=rowIndex)
    cameraDataSubset
      direction      street
    1       N/B   Caton Ave
    2       S/B   Caton Ave
    3       E/B The Alameda

* write.xlsx function will write out an Excel file
* read.xlsx3 is much faster than read.xlsx, but reading subsets of
rows may be slightly unstable
* the XLConnect package has more options for writing and manipulating
Excel files
* The XLConnect vignette is a good place to start for that package
* In general, store your data in either a database or in comma
  separated file or tab separated file, to make them easier to
  distribute.

## Reading XML ##
* Extensible markup language
* Fequently used to store structured data
* Particularly widely used in internet applications
* Extracting XML is the basis for most web scraping
* Components
    * Markup - labels that give the text structure
    * Content - the actual text of the document
* Tags, elements, and attributes
    * Start tags `<section>`
	* End tags `</section>`
	* Empty tags `<line-break />`
	* Elements `<Greeting> Hello, world </Greeting>`
	* Attributes `<img src="jeff.jpg" alt="instructor"/>`

Example

    library(XML)
    fileUrl <- "http://www.w3schools.com/xml/simple.xml"
    doc <- xmlTreeParse(fileUrl, useInternal=TRUE)
    rootNode <- xmlRoot(doc)
    xmlName(rootNode)
    [1] "breakfast_menu"
    names(rootNode]
      food   food   food   food   food
    "food" "food" "food" "food" "food"
    rootNode[[1]]
    <food>
      <name>Belgian Waffles</name>
      <price>$5.95</price>
      <description>Two of our famous Belgian Waffles with plenty of real maple syrup</description>
      <calories>650</calories>
    </food>
    rootNode[[1]][[1]]
    <name>Belgian Waffles</name>
    xmlSApply(rootNode, xmlValue)
     "Belgian Waffles$5.95Two of our famous Belgian Waffles with plenty of real maple syrup650"
    "French Toast$4.50Thick slices make from our homemade bread550"

* Use the Document Object Model (DOM) to extract pieces from XML
stored as an R object
* xml library functions
    * xmlName(), xmlNamespace() - element name (with or without the
    namespace)
    * xmlGetAttr(), xmlAttrs() - get one or more attributes
	* xmlValue() - get text content
	* xmlChildren, node[[ i ]], node [[ "el-name" ]] - get text
    content
	* xmlSApply()
	* xmlNamespaceDefinitions()
* XPath elements
    * /node - top-level node
    * //node - node at any level
	* node[@attr-name] - node that has an attribute named "attr-name"
	* node[@attr-name='bob'] - node that has an attribute named
    "attr-name" with value 'bob'
	* node/@x - value of attribute x in node with such attr.
	* `nodes <- getNodeSet(top, "//History/PubDate[@PubStatus='received']")`
	* Content of abstract as words

Example

    abstracts <- xpathApply(top, "//Abstract", xmlValue)
    abstractWords <- lapply(abstracts, strsplit, "[[:space:]]")
    library(Rstem)
	abstractWords <- lapply(abstractWords, function(x) wordStem[[1]])
	abstractWords <- lapply(abstractWords, function(x) x[x %in% stopWords])

Example from Baltimore Ravens web site

    fileUrl <- "http://espn.go.com/nfl/team/_/name/bal/baltimore-ravens"
	doc <- htmlTreeParse(fileUrl, useInternal=TRUE)
	# extract the xmlValue from lines that are list elements with class score
	scores <- xpathSApply(doc"//li[@class='score']", xmlValue)
	# and get the team-name list items
	teams <= xpathSApply(doc, "//li[@class='team-name']", xmlValue)
	scores
There are tutorials, I couldn't get the URL, but my friend Google knows.

## Reading JSON ##

* JavaScript Object Notation
* Lightweight data storage
* Common format for data from application programming interfaces
* Similar structure to XML but different syntax
* Data stored as
    * Numbers (double)
    * Strings (double quoted)
	* Boolean (*true* or *false*)
	* Array (ordered, comma separated, enclosed in square brackets)
	* Object (unordered, comma separated collation of Key:value pairs
    in curley braces

Example

    library{jsonlite}
    jsonData <- fromJSON("https://api.github.com/users/jtleek/repos")
    names(jsonData)
    names(jsonData$owner)
    names(jsonData$owner$login)
    myjson <- toJSON(iris, pretty=TRUE)
    cat(myjson)
    iris2 <- fromJSON(myjson)
    head(iris2)

There are tutorials. www.json.org has info too.

## data.table ##

Inherits from data.frame, but is much faster at subsetting,
grouping, and updating

    library(data.table)
    DF = data.frame(x=rnorm(9), y=rep(c("a", "b", "c"), each=3),z=rnorm(9))
    DT = data.table(x=rnorm(9), y=rep(c("a", "b", "c"), each=3),z=rnorm(9))

* Both make the almost the same structure, except that table table has
a colon (:) after the row numbers in the print out
* `tables()` shows all tables in memory
* `DT[2, ]` - selects row 2
* `DT[DT$y=="a",]` - selects rows where y is a
* `DT[c(2,3),]` - selects row 2 and 3
* `DT[,c(2,3)]` - uses expressions to figure out what to do. This one
  makes no sense to nothing comes out
* `DT[,list(mean(x),sum(z))]` - generates a table with 1 row, two
entries, V1=mean(x) and V2=sum(z), where x and z are elements of the
table we have been building
* `DT[,w:=z^2]` - adds a new column, w, which is equal to z^2
* Adding a column is faster because we are not making a copy of the
  data.table like we would have with a data.frame.
* `DT2 <- DT` - Makes DT2 a pointer to DT not a copy
* `DT2 <- copy(DT)`
* `DT[, y:= 2]` - set all the y entries in DT (and DT2) to 2
* `DT[,m:= {tmp <- (x+z); log2(tmp+5)}]` - You can do more than one
operation in the expression contained within the curly braces
* `DT[,a:=x>0]` - adds a column, a, which tells whether x is positive
* `DT[,b:=mean(x+w),by=a]` - Make one mean for rows where a is TRUE
and another mean for rows where a is FALSE - grouped-BY
* .N produces a count

New Table

    set.seed(123);
    DT <- data.table(x=sample(letters[1:3], IE5, TRUE))
    DT[, .N, by=x]
       x     N
    1: a 33387
    2: c 33201
    3: b 33412

Keys

    DT <- data.table(x=rep(c("a", "b", "c"), each=100), y=rnorm(300))
    setkey(DT, x)
    DT['a'] - prints all those entries in DT where x=="a"

Joins

    DT1 <- data.table(x=c('a', 'a', 'b', 'dt1'), y=1:4)
    DT2 <- data.table(x=c('a', 'b', 'dt2'), z=5:7)
    setkey(DT1, x); setkey(DT2, x)
    merge(DT1, DT2)
       x y z
    1: a 1 5
    2: a 2 5
    3: b 3 6

Data table reads from a file quickly, using fread(). read.table takes
longer.

	big_df <- data.frame(x=rnorm(1E6), y=rnorm(1E6))
    file <- tempfile()
    write.table(big_df, file=file, row.names=FALSE, col.names=TRUE,
    sep="\t", quote=FALSE)
    system.time(fread(file)) - .312 sec user
    system.time(read.table(file, header=TRUE, sep="\t")) - 5.702 user

There is a stack overflow article, what you can do with data frame
that you cannot do in data table.

## Expression example ##

Their functions are basically expressions, so as with those, the
return of an expression is the last thing computed.

    {
        x = 1
	    y = 2
	}
	k = {print(10); 5}
	[1] 10
	print{k}
	[1] 5


