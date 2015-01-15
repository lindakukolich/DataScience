---
title: "Notes2"
author: "Linda Kukolich"
date: "January 12, 2015"
output: html_document
---
# Reading mySQL
* Free and widely used open source database software
* Widely used in internet based applications
* Data are structured in 
    * databases
    * tables within databases
    * fields within tables
* Each row is called a record

1. Install mySQL *Does their stuff with with SQLite? which is the DB I have on my machine. My old copy from last year still works, so never mind.*
2. Install RMySQL `install.packages("RMySQL")` and `library(MySQL)`

Example: The UCSC Genome database, [http://genome.ucsc.edu], specifically [http://genome.ucsc.edu/goldenPath/help/mysql.html]
*Do not actually use their data. We might crash their server with the extra traffic. Oops*
```
ucscDb <- dBConnect(MySQL(), user="genome",
                    host="genome-mysql.cse.ucsc.edu")
                    result <- dbGetQuery(ucscDb, "show databases;"); dbDisconnect(ucscDb);
result
            Database
1 information_schema
2            ailMell
3            allMisl
4 anoCar1
5 anoCar2
6 anoGam1
7 apiMel1
8 apiMel2

hg19 <- dbConnect(MySQL(), user="genome", db="hg19", host="genome-mysql.cse.ucsc.edu")
allTables <- dbListTables(hg19)
length(allTables)
[1] 10949
allTables[1:5]
[1] "HInv" "HInvGeneMrna" "acembly" "acemblyClass" "acemblyPep"
# Get dimensions of a specific table
dbListFields(hg19, "affyUl133Plus2")
# ... lots of fields
# Run a query
dbGetQuery(hg19, "select count(*) from affyUl33Plus2")
count (*)
1  58463
affyData <- dbReadTable(hg19, "affyUl33Plus2")
head(affyData)
query <- dbSendQuery(hg19, "select * from affyUl33Plus2 where misMatches between 1 and 3")
affyMis <- fetch(query); quantile(affyMis$misMatches)
affyMisSmall <- fetch(query, n=10); dbClearResult(query);
dim(affyMisSmall)
[1] 10 22
# REMEMBER TO CLOSE THE CONNECTION
dbDisconnect(hg19)
```
## Further resources
* RMySQL vignette [http://cran.r-project.org/web/packages/RMySQL/RMySQL.pdf
]
* List of commands [http://www.pantz/org/sorftware/mysql/mysqlcommands.html]
    * **Do not DELETE, ADD, or JOIN things. Only select**
    * In the original notes it says that for ensembl, whatever that is.
    * In general be careful
* A nice blog post summarizing some other commands [http:/www.r-bloggers.com/mysql-and-r]

# HDF5

* Used for storing large data sets
* Supports storing a range of data types
* Heirarchical data format
* *groups* containing zero or more data sets and metadata
    * Have a *group header* with group name and list of attributes
    * Have a *group symbol table* with a list of object in group
* *datasets* multidimensional array of data elements with metadata
    * Have a *header* with name, datatype, dataspace, and storage layout
    * Have a *data array* with the data
* [http://www.hdfgroup.org]

## R HDF5 package

```
source("http://bioconductor.org/biocLite.R")
biocLite("rhdf5")
library(rhdf5)
created = h5createFile("eample.h5")
created
```

* This will install packages from [Bioconductor](http://bioconductor.org/), primarily used for genomics but also has good "big data" packages
* Can be used to interface with hdf5 data sets
* Good tutorial at [http://www.bioconductor.org/packages/release/bioc/vignettes/rhdf5/inst/doc/rhdf5.pdf]

```
# create groups
created = h5createGroup("example.h5", "foo")
created = h5createGroup("example.h5", "baa")
created = h5createGroup("example.h5", "foo/foobaa")
h51s("example.h5")
 group   name     otype dclass dim
0    /    baa H5I_GROUP
1    /    foo H5I_GROUP
2 /foo foobaa H5I_Group
# write to groups
A = matrix(1:10, nr=5, nc=2)
h5write(A, "example.h5", "foo/A")
B = array(seq(0.1, 2.0, by=0.1), dim=c(5, 2, 2))
attr(B, "scale") <- "liter"
h5write(B, "example.h5", "foo/foobaa/B")
h51s("example.h5")
        group   name       otype  dclass       dim
0           /    baa   H5I_GROUP
1           /    foo   H5I_GROUP
2        /foo      A H5I_DATASET INTEGER     5 x 2
3        /foo foobaa   H5I_GROUP
4 /foo/foobaa      B H51_DATASET   FLOAT 5 x 2 x 2
# write a data set
df = data.frame(1L:5L, seq(0, 1, length.out=5), c("ab", "cde", "fghi", "a", "s"), stringsAsFactors=FALSE)
h5write(df, "example.h5", "df")
h51s("example.h5")
        group   name       otype  dclass       dim
0           /    baa   H5I_GROUP
1           /     df H5I_DATASET COMPOUND        5
2           /    foo   H5I_GROUP
3        /foo      A H5I_DATASET INTEGER     5 x 2
4        /foo foobaa   H5I_GROUP
5 /foo/foobaa      B H51_DATASET   FLOAT 5 x 2 x 2
# reading data
readA = h5read("example.h5", "foo/A")
readB = h5read("example.h5", "foo/foobaa/B")
readdf = h5read("example.h5", "df")
     [,1] [,2]
[1,]    1    6
[2,]    2    7
[3,]    3    8
[4,]    4    9
[5,]    5   10
# ? = not <- ?
# writing and reading chunks
h5write(c(12, 23, 14), "example.h5", "foo/A", index=list(1:3,1))
h5read("example.h5", "foo/A")
     [,1] [,2]
[1,]   12    6
[2,]   13    7
[3,]   14    8
[4,]    4    9
[5,]    5   10
```

* hdf5 can be used to optimize reading/writing from disc in R
* Tutorial: [http://www.bioconductor.org/packages/release/bioc/vignettes/rhdf5/inst/doc/rhdf5.pdf]
* The HDF group has information on HDF5 in general [http://www.hdfgroup.org/HDF5/]

# Reading data from the web

**Webscraping**: Programatically extracting data from the HTML code o websites.

* It can be a great way to get data **How Netflix reverse engineered Hollywood**
* Many websites have information you may want to programatically use
* In some cases this is against the terms of service of the website
* Attempting to read to many pages too quickly can get your IP address blocked
* There is a wikipedia page on this

Example: Google Scholar
```
con <- url("http://scholar.google.com/citations?user=HI-I6C0AAAJ&hl=en")
htmlCode = readLines(con)
close(con)
htmlCode
# A print out of a web page, Jeff Leek's Google Scholar Citations
# Parsing with XML
library(XML)
url <- "http://scholar.google.com/citations?user=HI-I6C0AAAAJ&hl=en"
html <- htmlTreeParse(url, useInternalNotes=T)
xpathSApply(html, "//title", xmlValue)
[1] "Jeff Leek - Google Scholar Citations"
xpathSApply(html, "//td[@id='col-citedby']", xmlValue)
[1] "Cited by" "397" "259" ...
# Get from httr package
library(httr); html2 = GET(url)
content2 = content(html2, as="text")
parsedHtlm = htmlmParse(content2, asText = TRUE)
xpathSApply(parsedHtml, "//title", xmlValue)
"Jeff Leek - Google Scholar Citations"
# Accessing websites with passwords
pg1 = GET("http://httpbin.org/basic-auth/user/passwd")
pg1
Response [http://httpbin.org/basic-auth/user/passwd]
  Status: 401
  Content-type:

[http://cran.r-project.org/web/packages/httr/httr.pdf]
pg2 = GET("http://httpbin.org/basic-auth/user/passwd", authenticate("user", "passwd"))
pg2
Response [http://httpbin.org/basic-auth/user/passwd]
  Status: 200
  Content-type: application/json
  {
  "authenticated": true,
  "user": "user"
  }
names(pg2)
"url" "handle" "status_code" "headers" ...
# Using handles
google = handle("http://google.com")
pg1 = GET(hangle=google, path="/")
pg2 = GET(handle=google, path="search")
```

* R Bloggers has a number of examples of web scraping [http://www.r-bloggers.com/?s=Web+Scraping]
* The httr help file has useful examples
* See later lectures on APIs

# Reading data from APIs

Example: Twitter

* Create an application by visiting [https://dev.twitter.com/apps]
```
# Accessing Twitter from R
myapp = oauth_app("twitter", key="yourConsumerKeyHere", secret-"yourConsumerSecretHere")
sig = sign_oauth1.0(myapp, token = "yourTokenHere", token_secret = "yourTokenSecretHere")
homeTL = GET("https://api.twitter.com/1.1/statusses/hoe_timeline.json", sig)
# Converting the json object
json1 = content(homeTL)
json2 = jsonlite:fromJSON(toJSON(json1))
jsno2[1, 1:4]
created_at id id_str
1 Mon Jan 13 05:19:04 +0000 2014 4.225984e+17 422598398940694288
1 Now that P. Norvig's regex golf IPython notebook hit Slashdot, let's see if our traffic spike tops the
```
## How did I know what url to use?
[https://dev.twitter.com/docs/api/1.1/get/search/tweets]
## And read the documentation
[https://dev.twitter.com/docs/api/1.1/overview]

* httr allows GET, POST, PUT DELETE, requests if you are authorized
* You can authenticate with a user name or a password
* Most modern APIs using something like oauth
* httr works well with Facebook, Google, Twitter, Github, etc.

# Reading from other sources

There is a package for that. Find them by Googling `data storage mechanishm R package`

* Interacting with files
    * `file` - open a connection to a text file
    * `url` - open a connection to a url
    * `gzfile` open a connection to a .gz file
    * `bzfile` - open a connection to a .bz2 file
    * `?connections` for more information
    * **Remember to close connections**
* Foreign packages
    * read.arff(Weka)
    * read.dta(Stata)
    * read.mtp(Minitab)
    * read.octave(Octave)
    * read.spss(SPSS)
    * read.xport(SAS)
* Other Databases
    * RPostresSQL, a DBI-compliant database connection from R
    * RODBC interfaces to multiple databases, including PostgreQL, MySQL, Microsoft Access, and SQLite
    * R Mongo - interfaces to MongoDb
* Images
    * jpg
    * readbitmap
    * png
    *EBImage (Bioconductor)
* GIS data
    * rdgal
    * rgeos
    * raster
* Reading music data
    * tuneR
    * seewave

# Some notes about using equations in Rmd
$$ \sum_0^5 x = 15 $$
And what about inline? $\sqrt{2}$ A single dollarsign works. Double for equations on their own line. Oh cool:
$$
\begin{aligned}
\dot{x} & = \sigma(y-x) \\
\dot{y} & = \rho x - y - xz \\
\dot{z} & = -\beta z + xy
\end{aligned}
$$

# From the sqldf help page: SQL selectors and their R equivalents
```
a1r <- head(warpbreaks)
a1s <- sqldf("select * from warpbreaks limit 6")

a2r <- subset(CO2, grepl("^Qn", Plant))
a2s <- sqldf("select from CO2 where Plant like 'Qn%'")

a3r <- subset(farms, Manage %in% c("BF, "HF"))
row.names(a3r) <- NULL
a3s <- sqldf("select * from farms where Manage in ('BF', 'HF')")

a4r <- subset(warpbreaks, breaks >= 20 & breaks <= 30)
a4s <- sqldf("select * from warpbreaks where breaks between 20 and 30", row.names=TRUE)

a5r <- subset(farms, Mois == 'M1')
a5s <- sqldf("select * from farms where Mois = 'M1'", row.names=TRUE)

a6r <- subset(farms, Mois == 'M2')
a6s <- sqldf("select * from farms where Mois = 'M2'", row.names=TRUE)
# rbind
a7r <- rbins(a5r, a6r)
a7s <- sqldf("select * from a5s union all select * from a6s")
# sqldf drops the unused levels from Mois but rbind does not; however,
# all data is the same and the other columns are identical

# aggregate - avg conc and uptake by Plant and Type
a8r <- aggregate(iris[1:2], iris[5], mean)
a8r <- sqldf('select Species, avg("Sepal.Length") `Sepal.Length`, avg("Sepal.Width") `Sepal.Width` from iris group by Species`)

# by - avg conc and uptake by Plant and Type
a9r <- do.cal(rbind, by(iris, iris[5], function(x) with (x, data.frame(Species = Species[1], mean.sepal.Length = mean(Sepal.Length), mean.Sepal.Width = mean(Sepal.Width), mean.Sepal.ratio = mean(Sepal.Length/Sepal.Width)))))
a9s <- sqldf('select Species, avg("Sepal.Length") `mean.Sepal.Length`, avg("Sepal.Width") `mean.Sepal.Width`, avg("Sepal.Length"/"Sepal.Width") `mean.Sepal.ratio` from iris group by Species))

# table
a15r <- table(warpbreaks$tension, warpbreaks$wool)
a15s <- sqldf("select sum(wool = 'A'), sum(wool = 'B') from warpbreaks group by tension")
```
    select "column1"
      [,"column2",etc] 
      from "tablename"
      [where "condition"];

Relationship in condition

=  Equal
>	Greater than
<	Less than
>=	Greater than or equal
<=	Less than or equal
<>	Not equal to
LIKE	*See note below

The LIKE pattern matching operator can also be used in the conditional selection of the where clause. Like is a very powerful operator that allows you to select only rows that are "like" what you specify. The percent sign "%" can be used as a wild card to match any possible character that might appear before or after the characters specified. 
```
