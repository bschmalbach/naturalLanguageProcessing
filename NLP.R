library(tm)
library(rtweet)
library(wordcloud)
library(RColorBrewer)
library(e1071)
library(class)
library(openssl)
library(httpuv)


api_key <- ""
api_secret <- ""
access_token <- ""
access_secret <- ""

twitter_token <- create_token(
  app = "NLP_Exercise28082020",
  consumer_key = api_key,
  consumer_secret = api_secret,
  access_token = access_token,
  access_secret = access_secret)

#get tweets
tweets <- search_tweets("basketball", n=1000, lang="en")
text <- tweets$text


#clean text and make corpus

text <- iconv(text, "UTF-8", "ASCII")
corpus <- Corpus(VectorSource(text))

#make tdm

tdm <- TermDocumentMatrix(corpus, control = list(removePunctuation=T, stopwords=c("basketball", "http", stopwords("english")),
                                                 removeNumbers=T,
                                                 tolower=T))
tdm <- as.matrix(tdm)

count <- sort(rowSums(tdm), decreasing = T)
dm <- data.frame(word=names(count), freq=count)

wordcloud(dm$word, dm$freq, random.order = F)



