import tweepy
import time

consumer_key = 'fg5rJhJ1DrjZ8nR3nu7W0kodP'
consumer_secret = 'zfjJbiw9CYk5sM6wE0C2WLyAKJVD65SgfRN2PjxL2gTn2XuRap'
access_token = '1548377478-qmsIsjZrfCcM2Mu4Tm3DrCxNXbqbRGsej06TK9Q'
access_token_secret = '78KORYxzvnBK7SiWqf437OdGOsNiYNHVAkxVVn9oFk6q1'

auth = tweepy.OAuthHandler(consumer_key, consumer_secret)
auth.set_access_token(access_token, access_token_secret)

api = tweepy.API(auth)

clk=time.strftime("%d-%m-%H-%M")

tweetf= open("SNP_T_SO"+clk+".txt", "wt")
tweetc= open("SNP_C_SO"+clk+".txt", "wt")

class INtweet:
  ID=[]
  Umetntionee=[]
  Hmetntionee=[]
  geo=[]




i=1
for tweet in tweepy.Cursor(api.search,
                           q="SNP",
                           count=100000,
                           result_type="recent",
                           include_entities=True,
                           lang="en").items(100000):
    corp=tweet.text
    #cp=corp.decode('unicode_escape').encode('ascii','ignore')
    
#Use the class that you have design at top to save the geo and ID of each tweet. 
#Also check with the toolbox to see if they have something built-in to recognise the mentionee and hashtages that was mentioned.
    mi=1
    for i in range(len(corp)):
      if '@'==corpnew[i]:
        corpt=corp[i:]
        corptt=corpt.rsplit(' ')
        INtweet.Umetntionee.append(corptt[0])
        mi+=1

    tweetf.write(str(i)+";"+str(tweet.id)+";"+str(tweet.coordinates)+";"+corp.encode('utf-8')+ '\n')
    tweetc.write(str(i)+";"+str(tweet.user.id)+";"+str(tweet.created_at)+ '\n')
    print tweet.created_at, tweet.text
    del corp
    i+=1
tweetf.close()
tweetc.close()
