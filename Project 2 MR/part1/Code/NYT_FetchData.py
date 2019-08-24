import urllib.request
import json
import pprint
import os
import datetime

def getArticleHtml(link):
    try:
        response = urllib.request.urlopen(link)
        webContent = response.read()
        now = datetime.datetime.now()
        fileName = str(now.strftime("%Y-%m-%d %H:%M:%S"))+ ":" + str(now.microsecond) + ".html"
        fileName = fileName.replace(':', " ")
        print(fileName)
        f = open(fileName, 'wb')
        f.write(webContent)
        f.close
    except:
        print("prblem with : \n",link)


api_Key = os.environ.get('NY_API_KEY')
nyTimesUrl = 'https://api.nytimes.com/svc/search/v2/articlesearch.json?q="Houston Dynamo"&Page=0&begin_date=20190101&api-key='+ api_Key
print(nyTimesUrl)
urlDataJson = urllib.request.urlopen(nyTimesUrl).read()
urlData = json.loads(urlDataJson)
data = urlData['response']
urlLinks = []

for index in range(len(data['docs'])):
    urlLinks.append(data['docs'][index]['web_url'])
    getArticleHtml(data['docs'][index]['web_url'])

print(urlLinks)

