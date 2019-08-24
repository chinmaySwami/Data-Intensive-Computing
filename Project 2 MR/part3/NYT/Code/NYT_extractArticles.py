from bs4 import BeautifulSoup
import os
import re
import os
from nltk.corpus import stopwords
stop_words = set(stopwords.words('english'))
stop_words.update(['pdf', 'doc', 'url', 'said'])

def nlp_preprocessing(total_text, count_records):
    if type(total_text) is not int:
        string = ""
        for words in total_text.split():
            # remove the special chars in review like '"#$@!%^&*()_+-~?>< etc.
            #word = (''.join(i for i in words if not i.isdigit()))
            word = ("".join(e for e in words if e.isalnum()))
            #word = word.translate(str.maketrans('','','{}'))
            # Conver all letters to lower-case
            word = word.lower()
            # stop-word removal
            if not word in stop_words:
                string += word + " "
        return string

path = "D:/University/Sem2/DIC/Projects/Lab2DataInfra/data/nyt/MLB"
filelist = os.listdir(path)
print("\n", path)
count = 0
for filename in filelist:
    print(filename)
    fName = "MLB/"+filename
    try:
        parsed_html = BeautifulSoup(open(fName,encoding="utf8"), "html.parser")
        article = parsed_html.body.find('section', attrs={'name':'articleBody'}).text
        article = re.sub(r"http\S+", "", article)
        article = (''.join(i for i in article if not i.isdigit()))
        article = article.translate(str.maketrans('', '', '{}'))
        article = nlp_preprocessing(article, 1)
        f = open("MLB/txt_files/"+filename.replace(".html",".txt"), 'wb')
        f.write(article.encode('utf-8'))
        f.close
    except:
        print("prblem with : \n", filename)
