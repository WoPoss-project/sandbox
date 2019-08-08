import stanfordnlp
import sys
nlp = stanfordnlp.Pipeline(lang="la", treebank="la_perseus")
input = open(sys.argv[1], 'r')
doc = input.read()
results = nlp(doc)
with open(sys.argv[2], "w+") as f:
    print(results.conll_file.conll_as_string(), file=f)
