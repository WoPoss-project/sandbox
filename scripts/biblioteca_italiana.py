import urllib.request
import os.path
import sre_yield

#Write down the URLs Biblioteca Italiana XML

corpus = list(sre_yield.AllStrings(r"http://backend\.bibliotecaitaliana\.it/wp-json/muruca-core/v1/xml/bibit[0-9]{6}"))

for pg in corpus:
    name = os.path.basename(pg)
    urllib.request.urlretrieve(pg, '/home/hbermude/Bureau/test/' + name)