import stanfordnlp
nlp = stanfordnlp.Pipeline(lang="la")
#nlp = stanfordnlp.Pipeline(lang="la", treebank="la_ittb")
#nlp = stanfordnlp.Pipeline(lang="la", treebank="la_perseus")
#nlp = stanfordnlp.Pipeline(lang="la", treebank="la_proiel")
input = open('sample.txt', 'r')
doc = input.read()
results = nlp(doc)
with open("output.txt", "a") as f:
    print(results.conll_file.conll_as_string(), file=f)