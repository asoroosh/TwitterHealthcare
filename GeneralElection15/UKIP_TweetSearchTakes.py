
# Scrapes the tweets containing the word UKIP
# This code was used before the UK General Election in 2015
# Soroosh Afyouni, 2015


import tweepy
import time

qq="UKIP"
Nums=100000

consumer_key = 'XXX'
consumer_secret = 'XXX'
access_token = 'XXX'
access_token_secret = 'XXX'

auth = tweepy.OAuthHandler(consumer_key, consumer_secret)
auth.set_access_token(access_token, access_token_secret)

api = tweepy.API(auth)

clk=time.strftime("%d-%m-%H-%M")

tweetf= open(qq+"_SO"+clk+".txt", "wt")
tweetc= open(qq+"_C_SO"+clk+".txt", "wt")

i=1
while True:
     try:
        for tweet in tweepy.Cursor(api.search,
                           q=qq,
                           count=Nums,
                           result_type="recent",
                           include_entities=True,
                           lang="en").items(Nums):
          corp=tweet.text
          #cp=corp.decode('unicode_escape').encode('ascii','ignore')
          print tweet.created_at,corp

          tweetf.write(str(i)+";"+str(tweet.id)+";"+str(tweet.coordinates)+";"+corp.encode('utf-8')+ '\n')
          tweetc.write(str(i)+";"+str(tweet.user.id)+";"+str(tweet.created_at)+ '\n')
          del corp
          i+=1
     except tweepy.TweepError:
        pclk=time.strftime("%d-%m-%H-%M")
        print "****************Suspended for 15mins due to API limit at "+pclk+" ************"
        time.sleep(60 * 15)
        continue
     except StopIteration:
        break
tweetf.close()
tweetc.close()
