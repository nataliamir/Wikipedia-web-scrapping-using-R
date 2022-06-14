## Installing and loading libraries
install.packages('rvest')
install.packages('tm')
install.packages('NLP')
library(rvest)
library(NLP)
library(tm)

## Downloading HTML
wikipedia <- read_html("https://en.wikipedia.org/wiki/Olympic_Games", stringsAsFactors=FALSE)

## Collecting CSS selectors using SelectorGadget for Chrome
## Note: All titles (h) and paragraphs (p) from the article were selected (excluding Wikipedia's generic menus).
node <- html_nodes(wikipedia, "p, h1, h2, h3, h4")
text <- html_text(node)

## Collapsing all text
df <- data.frame(V1=c(text))
collapse <- paste(df$V1, collapse=" ")

## Creating source and corpus
source <- VectorSource(collapse)
corpus1 <- Corpus(source)

## Cleaning and preparing text
corpus1 <- tm_map(corpus1, content_transformer(tolower))
corpus1 <- tm_map(corpus1, removePunctuation)
corpus1 <- tm_map(corpus1, stripWhitespace)

## Document-Term Matrix
dtm1.1 <- DocumentTermMatrix(corpus1)
dtm1.2 <- as.matrix(dtm1.1)

## Counting and sorting word frequencies
frequency1 <- colSums(dtm1.2)
frequency1 <- sort(frequency1, decreasing=TRUE)
print(frequency1)
head(frequency1)

## Removing stopwords
corpus2 <- tm_map(corpus1, removeWords, stopwords("english"))

## Document-Term Matrix after disregarding stopwords
dtm2.1 <- DocumentTermMatrix(corpus2)
dtm2.2 <- as.matrix(dtm2.1)

## Counting and sorting word frequencies after disregarding stopwords
frequency2 <- colSums(dtm2.2)
frequency2 <- sort(frequency2, decreasing=TRUE)
print(frequency2)
head(frequency2)
