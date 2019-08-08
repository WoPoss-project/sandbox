from bs4 import BeautifulSoup
from urllib.request import urlopen
import sre_yield

#Write down the URLs that contain the 50 books of the Genesis

genesis = list(sre_yield.AllStrings(r"http://www\.intratext\.com/IXT/LAT0669/__PX[U-Z]\.HTM")) \
          + list(sre_yield.AllStrings(r"http://www\.intratext\.com/IXT/LAT0669/__PY[0-5]\.HTM"))

#Create XML and skeleton

f = open('corinthians2.xml', 'w')
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
