counts_raw <- read.delim("data/counts-raw.txt")
dim(counts_raw)
head(counts_raw)
counts_raw[1, 10]
counts_raw[1:3, 10:12]
counts_raw[1:10, "pmid"]
# Look at structure/datatype of dataframe
str(counts_raw$daysSincePublished)
# Find number of weeks since published rather than days
head(counts_raw$daysSincePublished / 7)
# Alternate dividing by two numbers - "recycles" values
# Doesn't actually work
head(counts_raw$daysSincePublished / c(7, 1))
# Test datatype
is.numeric(counts_raw$daysSincePublished)
# Factors - handle categorical data
str(counts_raw$journal)
levels(counts_raw$journal)
counts_raw$authorsCount[1:10]
anyNA(counts_raw$authorsCount[1:10])
summary(counts_raw$wosCountThru2011)
hist(sqrt(counts_raw$wosCountThru2011))
plot(counts_raw$daysSincePublished, counts_raw$wosCountThru2011)

#Conditional Statements
counts_raw$authorsCount[1:10] > 7
#Find dimensions of sub matrix where the journal is not plos one
dim(counts_raw[counts_raw$journal != 'pone', ])
# Same as above but in any of three specific journals
dim(counts_raw[counts_raw$journal %in% c("pone", "pbio", "pgen"), ])
# Find number of papers that has Immunology in the subject tag
# Grepl -> returns True/false, grep returns index
dim(counts_raw[grepl("Immunology", counts_raw$plosSubjectTags), ])
head(counts_raw$plosSubjectTags)

dim(counts_raw[grepl("Evolutionary Biology", counts_raw$plosSubjectTags), ])

#Loops
#Use indexing rather than adding to a vector to make loops in R run faster

x <- numeric(length = length(counts_raw$wosCountThru2011))
for (i in 1:length(counts_raw$wosCountThru2011)) {
  x[i] <- counts_raw$wosCountThru2011[i] + 1
}

levels(counts_raw$journal)
results <- numeric(length = length(levels(counts_raw$journal)))
results
names(results) <- levels(counts_raw$journal)
results
results["pone"]

for (j in levels(counts_raw$journal)) {
  results[j] <- mean(counts_raw$wosCountThru2011[counts_raw$journal == j])
}
results
