library(tm)
library(rtweet)
library(wordcloud)
library(RColorBrewer)
library(e1071)
library(class)
library(openssl)
library(httpuv)


api_key <- "1y3968JuMOhSWaoVQtUk1th2o"
api_secret <- "rhBQDLzW8RsqX3O7PU4vtmd0sAECwmhzDKdb0X90H7jxn0S1fq"
access_token <- "1286624759267065856-2N0R1OYk9HrCePEXuOxTyG3WtttdYQ"
access_secret <- "UaygkqMpQ37bhFMPjnc025dbWwgzrVfYB9ErARJFxAKl8"

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



