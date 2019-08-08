from bs4 import BeautifulSoup
from urllib.request import urlopen
import sre_yield

#Write down the URLs that contain the 50 books of the Genesis

genesis = list(sre_yield.AllStrings(r"http://www\.intratext\.com/IXT/LAT0669/__P9[J-Z]\.HTM")) + list(sre_yield.AllStrings(
r"http://www\.intratext\.com/IXT/LAT0669/__PA[A-B]\.HTM"))

#P9J & PAB

#PAC & PBB



#Create XML and skeleton

f = open('judges.xml', 'w')
head = """<text>
    <div>"""
foot = """</div>
    </text>"""

f.write(head)

#Retrieve <p> for each URL

for pg in genesis:
    page = urlopen(pg)
    html = BeautifulSoup(page, "html.parser")
    content = html.find_all('p')

    #Write it in the file as a string

    text = str(content)
    f.writelines(text)

#End file
f.write(foot)
f.close()
