# Week 1

## Series Motivation
- The question should come first, and then the data. Can you answer the question you are interested in solving with the data you have available?
- Caffo - brain imaging
- Leek - genomic data
- Peng - fine particulate matter
- Why Data Science? There is a ton of data that is easier to collect and store than it ever has been. There is even money out there available as prizes to folks who solve data science puzzles.
-We will be using R because there are so many packages for all the processes in data science and a nice IDE. Ipong could be used.
-Data Science intersects 3 skills, Math & Statistics Knowledge, Hacking Skills, and Substantive Expertise
Hacking Skills are needed partly because you can code and partly because you need to do your own seraches to find out stuff. This isn't all collected together and crystalized for you yet.

## The Data Scientist's Toolbox
- Tasks of a Data Scientist
  - Define the question
  - Define the ideal data set
  - Determine what data you can access
  - Obtain the data
  - Clean the data
  - Exploratory data analysis
  - Statistical prediction/modeling
  - Interpret results
  - Challenge results
  - Synthesize/write up results
  - Create reporducible code
  - Distribute results to other people
- Tools
  - Main tool is R and its IDE, RStudio
  - R Markdown - Document  (.Rmd)
  - Git for version control and GitHub for distribution

## Getting Help
- Post questions to message boards and up-vote or respond to questions.
- Try to answer your own questions using other online resources
  - Google
  - R documentation
    - ?rnorm
    - help.search("rnorm")
    - args("rnorm")
    - rnorm # shows the code itself, which turns out to be a call to a C function
    - http://cran.r-project.org/doc/contrib/Short-refcard.pdf
- Post your answers when you have found them for yourself, for the sake of your classmates
- How to ask an R question
  - What steps will reporduce the problem?
  - What is the expected output
  - What do you see instead?
  - What verison of the product are you using?
  - What OS and version do you have?
- How to ask a data analysis question
  - What is the question you are trying to answer?
  - What setsp/tools did you use to answer it?
  - What id you expect to see?
  - What do you see instead?
  - What other solutions have you thought about? (Avoid them responding with low hanging fruit)
- Good Titles for questions
  - R 2.15.0 lm() function on Mac OSX 10.6.3 -- seg fault on large data frame
  - Using principal components to discover common variation in rows of a matrix, shoud I use U, D, or V^T
- Good Etiquette
  - Describe the goal
  - Be explicit
  - Be brief
  - Be polite
  - Follow-up when you find an answer
- Bad Etiquette
  - Ask other people to do your homework
  - Post homework questions on mailing lists or forums
  - Email multiple lists at the same time or send to the wrong lists
  - Ask General data analysis questions on R forums

## Finding Answers
- Characteristics of a Data Hacker
  - Be willing to find your own answers
  - Learn where to look for them
  - Be willing to learn new packages and new data types
  - Be willing to admit ignorance
  - Be polite but relentless
- Where to look for different questions
  - R programming
    - Class forum archives
    - RTFM
    - Read the Web
    - Ask a skilled friend
    - Post to class forums
    - Post ot R mailing list or Stackoverflow
  - Data Analysis/Statistics
    - Same, but post to CrossValidated
- How to Google Data Science Questions
  - Stackoverflow, use the tag "[r]"
  - Google [data type] data analysis, [data type] R package
    - biostatistics - medical data
    - Data Science - web analytics
    - Machine Learning (machine learning)
    - Natural Language processing (text processing)
    - Signal processing (data from electrical signals)
    - Business analytics (data on customers)
    - Econometrics (economic data)
    - Statistical process controll (data about industrial processes)

## Courses in Data Science Track
### R Programming Overview
- Data types
- Subsetting
- Reading and writing data
- Control structures
- Fonctions
- Scoping
- Vectorized operations
- Dates and times
- Debugging
- Simulation
- Optimization

- readLine
- lapply

### Getting Data Overview
- Raw vs. tidy data
  - Original source
  - often hard to use for data analyses
  - data analysis inclues processing
  - raw data may only need to be processed once
  - Processed data is ready for analysis
  - processing can include merging, subsetting, transforming, etc
  - All steps should be recorded
- Downloading files
- Reading data (Excel, XML, JSON, MySQL, HDF5, Web)
  - dbConnect()
  - merge()
- Merging data
- Reshaping data
- Summerizing data
- Finding and replacing
- Data resources

### Exploratory Data Analysis Overview
- Principles of analytic graphics
  1. Show comparisons
  2. Show causality, mechanism, explanaton
  3. Show multivariate data
  4. Integrate multiple modes of evidence
  5. Describe and document the evidence
  6. Content is king
- exploratory graphs
- plotting systems in R
  - base
  - lattice
  - ggplot2
- Hierarchical clusting, k-means clustering, dimensional reduction

### Reproducible Research Overview
- Structure of Data Analysis
  - Define the question
  - Define the ideal data set
  - Determine what data you can access
  - Obtain the data
  - clean the data
  - Exploratory data analysis
  - Statistical prediction/modeling
  - Interpret results
  - Challenge results
  - Synthesize/write up results
  - Create reproducible code
- Organizing a Data Analysis
  - Data, Raw and Processed
  - Figures, Exploratory and Final
  - R Code, Raw scripts and Final Scripts and Markdown files
  - Text - Readme and Analysis files
- Markdown
- LaTeX
- R Markdown
- Evidence-based data analysis
- RPubs

### Statistical Inference Overview
- Basic probability
- Likelihood
- Common distributions
- Asymptotics
- Confidence intervals
- Hypothesis tests
- Power
- Bootstrapping
- Non-parametric tests
- Basic bayesian statistics

### Regression Models Overview
- Linear regression
- Muliple regression
- Confounding
- Residuals and diagnostics
- And so much more...
- Regression to the mean
- More math than some other classes, but they will deny us the Calculus that could make the derivations easy. :(

### Practical Machine Learning Overview
- Machine learning in R
- There are other classes for Machine learning in other languages
- caret
- cross validation
- prediction trees
- forecasing
- Sensitivity and specificity
- Correlated predictors
- boosting

### Building Data Products Overview
- How to build your own R package
- rCharts, Slidify, Shiny

# Week 2
## Command Line Interface
- Describing how command line interfaces work, for folks who need to know what a directory is because they have only dealt with "folders" and GUIs up to now.
- GitBash for windows folks, Terminal for Mac folks
- pwd
- mkdir
- cd
- cd ..
- rm
- rmdir
- rm -r
- clear
- ls
- ls -a
- touch
- cp
- mv
- date
- echo

## Introduction to Git
- Version control records changes so you can recall certain versions later
- git config --globar user.name "Your Name"
- git config --global user.email "your_email'
- git config --list

## Introduction to GitHub
- push and pull from the web
- homepage to show your code
- social aspect allows users to follow one another
- "Build software better, together."
- Edit your profile to help you take credit for your good work

## Creating a GitHub Repository
- creating a repository using the GitHub GUI.
- For 6 excruciating minutes
- Granted, this would be more interesting if I were the target audience of the lecture...
  - git init
  - git remote add origin https://github.com/yourUserNameHere/test-repo.git
- Also make a fork
  - git clone https://github.com/yourUserNameHere/repoNameHere.git
- git push
- Promises that it is possible to keep a fork up to date, which will be interesting to see.

## Basic Git Commands
- add
  - add files in workspace to index
  - git add . [ adds all new files ]
  - git add -u [ updates tracking for files that changes names or were deleted ]
  - git add -A [ both . and -u ]
- commit
  - save changes in the index to the local repository
  - git commit -m "insert your message here"
- push
  - send local changes to GitHub
- branches
  - git checkout -b branchname
  - git branch
  - git checkout master
- merge, pull request
  - pull request is a feature of GitHub
    - select a branch
    - prepare pull request
    - owner reviews and approves pull request, accepting changes
- checkout (HEAD)
- fetch
- pull
- diff (HEAD)
- status

## Basic Markdown
- File.md
- Headings, Marked with increasing pound signs
- unordered lists marked with asterix or dash
- Good MD help within RStudio

## Installing R Packages
- A big reason R is so cool is the large number of packages
- a <- available.packages()
- head(rownames(a), 3)
- 5200 packages on CRAN
- Packages at CRAN
- Bioconductor Project for biological packages
- Installing CRAN packages
  - install.packages("slidify")
  - install.packages(c("slidify", "ggplot2", "devtools"))
  - takes care of dependencies for you, too
  - Also Install Packages menu item in RStudio
- Installing Bioconductor packages
  - source("http://bioconductor.org/biocLite.R")
  - biocLite()
  - biocLite(c("GenomicFeatures", "AnnotationDbi"))
- Load packages
  - library(ggplot2)
  - Note, do not put the package name in quotes when loading
  - search() to see the functions exported by the package

## Installing Rtools
- Needed by Windows Users, so I skipped this one.

# Week 3

## Types of Questions
* Descriptive
  * Describe a set of data
  * Commonly applied to census data
  * Description and interpretation are different steps
  * Ngram viewer from Google is an example
* Exploratory
  * Find relationships you didn't know about
  * Useful for defining future studies
  * Ususally not the final say and shouldn't be used for generalizing/predicint.
  * Correlation does not imply causation
* Inferential
  * Use a relatively small sample of data to say something about a bigger population
  * Inference is commonly the goal of statistical models
  * Involves estimating the quantity you care about and the uncertainty
  * Depends on population and sampling scheme
  * "Effect of Air Pollution Control on Life Expectancy on the United States: An Analysis of 545 US Couties for the Period from 2000 - 2007
* Predictive
  * To use the data on some objects to predict values for another object
  * If X predicts Y it does not mean that X causes Y
  * Depends heavily on measureing the right variables
  * More data ususally helps. Simple models really help
  * FiveThirtyEight's prediction of the presidential election results
* Causal
  * To find out what happens to one variable when you make another variable change
  * Ususally randomized studies are required to identify causation
  * You need to make more assumptions to work with non-randomized data
  * Causal relationships are usually identified as average effects
  * Duodenal Infusion of Donor Feces for Recurrent C-difficile
* Mechanistic
  * Understand the exact changes in variables that lead to chainges in other individual objexts
  * Incredibly hard to infer, except in simple situtations
  * Usually modeled by a deteministic set of equations
  * Generally the random component is measurement error
  * Empirical Pavement Design

## What is Data?
* Data are values of qualitative or quantitative variables, belonging to a set of items.
* Set of Items: population
* Qualitative: Country of origin, sex, treatment. Not ordered
* Quantitative: Height, Weight. Can be ordered
* Data examples
  * Cat video frames
  * Audio files
  * API data, www.data.gov
* Data is the second most importat thing in data science
* The Most important thing is the question

## What about Big Data?
* There is more data now than before
* Don't use Hadoop, your data is not THAT big
* The data may not conatin the answer. The combination of some data and an aching desire for an answer does not ensure that a reasonable ansewr can be extracted from a given body of data... , no matter how big the data are

## Experimental Design
* An example of why you should care
  * Genomic signatures to guide the use of chemotherapeutics (opens door to personalized medicide to tune treatment for cancer treatment. Exciting!)
  * Deriving chemosensitivity from cell lines: forensic bioinformatics and reporducible sresearch in high-thorughput biology - flawed statistical analysis and unfortunately clinical trial has already started
  * Lawsuit from the people enrolled in the trial against the investigators who developed the predictive model
* Care about how your analysis will be done.
* How do deal with data
  * Plan for data and code sharing.
  * Small amounts of data can go on github, larger on figshare. even larger found in the datasharing code we forked as part of our homework
* Formulate your question in advance
  * Question: Does changing the text on your website improve donations
  * Experiment:
    * Randomly show two versions of the web site
    * record how much is donated
    * determine which is better
  * Analysis
    * Statistical inference: Cannot show website to everyone)
    * Population is all possible donors
    * Select a smaller subset to show two versions of the website to
    * Generate descriptive statistics to show donations per visit
    * Generate inferential statistics to determine which one to use
  * Shows 3 scenarios
    * Small difference, large differnece in variability (Maybe worth changing, but cannot tell)
    * Small difference in average result, small difference in variability (Definitely better, but difference is so small it may not be worth the cost of development)
    * Large difference in average result, small difference in variability - probably worth making the change.
 * Confounding - Show size versus literacy, ignoring age
* Randomization and blocking
  * If you can, fix a variable (use fixed text on the page)
  * If you don't fix it, stratify it (use both phrases eqally on both web site)
  * If you don't stratify it, randomize it (assumes you have a confounding variable. If there is a correlation between the confounding variable and the treatment, you can't tell if it is the treatment that worked, or the confounding variable that made it work)
* Also showed us histgram curves that had a lot of overlap and two curves that didn't. 
* Prediction Key Quantities
  * Sensitivity Pr(positive test | disease) [Probability of a posititive test given that the patient has the disease)
  * Specificity Pr(negative test | no disease)
  * Positive Predictive Value Pr(disease | positive test)
  * Negative Predictive Value Pr(no disease | negative test)
  * Accuracy Pr(correct outcome) - though, not weighted, no maybe not the most useful
* Beware of data dredging - keep trolling though the data till you find a subset that supports your conclusion
* Summary 
  * Good experiments
    * Have replication
    * Measrure variability
    * Generalize to the problem you care about
    * Are transparent (share code and data and make both easy to use)
  * Prediction is not inference
    * Both can be important
  * Beware data dredging
