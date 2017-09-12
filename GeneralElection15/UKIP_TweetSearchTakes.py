import tweepy
import time

qq="UKIP"
Nums=100000

consumer_key = 'fg5rJhJ1DrjZ8nR3nu7W0kodP'
consumer_secret = 'zfjJbiw9CYk5sM6wE0C2WLyAKJVD65SgfRN2PjxL2gTn2XuRap'
access_token = '1548377478-qmsIsjZrfCcM2Mu4Tm3DrCxNXbqbRGsej06TK9Q'
access_token_secret = '78KORYxzvnBK7SiWqf437OdGOsNiYNHVAkxVVn9oFk6q1'

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
