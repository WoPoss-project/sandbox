#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Fri Jul 19 18:16:07 2019

@author: ruizfabo

Modified by Helena on Jul 22 2019
"""

from copy import deepcopy
from lxml import etree
import os
import pyconll as pc
import sys


def accumulate_deps(idlist, sente, collected=[]):
    """
    Get the complete phrase governed by the heads in idlist
    """
    #import pdb
    #pdb.set_trace()
    alldeps = collected

    if len(idlist) > 0:     
        for myid in idlist:
            ids2 = [word.id for word in sente if word.head == myid]
            if myid not in alldeps:
                alldeps.append(myid)
                if DBG:
                    _print_dbg_infos(idlist, ids2)
            _ = accumulate_deps(ids2, sente, collected=alldeps)

    return sorted(alldeps)


def grab_initial_sentences(cob, nbr=1, delim="~~~"):
    sents_out = []
    for sent in cob[0:nbr+1]:
        sents_out.append(" ".join([word.form for word in sent]))
    return delim.join(sents_out)      


def ana_file(fname, lemma, deprel, outdir):
    """
    Go over a CONLL-U file looking for the relevant information.
    Write out to XML.
    """
    co = pc.load_from_file(fname)
    
    initial_sents = grab_initial_sentences(co)
    
    root = etree.Element("file")

    keep_file_set = False

    for idx, sent in enumerate(co):

        has_lemma = False
        has_dep = False

        lemma_ids = [word.id for word in sent if word.lemma == lemma]
        #lemma_ids = [word.id for word in sent if lemma in word.lemma]
        if len(lemma_ids) > 0:
            print("## SENT:", " ".join(["{}~{}".format(word.form, word.id) for word in sent]))
            print(idx, ": LEMMA AT: ", lemma_ids)
            has_lemma = True
        if len(lemma_ids) > 0:
            for lemma_id in lemma_ids:
                lemma_dep_ids = [word.id for word in sent
                                 if word.head == lemma_id
                                 and word.deprel == deprel
                                 and "Case" in word.feats
                                 # word.feats is a set so "Abl" is IN the set,
                                 # cannot be equal to the set
                                 # or else test with word.feats["Case"] == set("Abl")
                                 and "Abl" in word.feats["Case"]]
                bkp_deep = deepcopy(lemma_dep_ids)
                bkp_normal = lemma_dep_ids
                if len(lemma_dep_ids) > 0:
                    print(idx, ": OBL IDS ORIG: ", lemma_dep_ids)
                    print(idx, ": OBL Cases   : ", 
                          [word.feats["Case"] for word in sent
                           if "Case" in word.feats
                           and word.id in lemma_dep_ids])
                    has_dep = True
                dep_all = accumulate_deps(lemma_dep_ids, sent,
                                          collected=lemma_dep_ids)
                dep_all_words = [word.form for word in sent
                                 if int(word.id) in sorted([int(x)
                                 for x in dep_all])]
            if has_lemma and has_dep:
                print(idx, ":", "|".join([str(y) for y in sorted([int(x)
                                          for x in dep_all])]))
                print(idx, ":", " ".join(dep_all_words))
                print("\n")
                if not keep_file_set:
                    add_to_xml_out(root, fname, initial_sents, sent,
                                   lemma_id,
                                   #lemma_dep_ids,
                                   bkp_deep,
                                   dep_all, dep_all_words,
                                   new_xml=True)
                    keep_file_set = True
                else:
                    add_to_xml_out(root, fname, initial_sents, sent,
                                   lemma_id,
                                   #lemma_dep_ids,
                                   bkp_deep,
                                   dep_all, dep_all_words,
                                   new_xml=False)
                    
            elif has_lemma and not has_dep:
                print("\n")
    # serialize the xml at this level
    if keep_file_set:
        print("######################################")
        #import pdb;pdb.set_trace()
        sertree = etree.tostring(root, xml_declaration=True,
                                 encoding="UTF-8", pretty_print=True)
        ofname = os.path.join(
            outdir, os.path.splitext(os.path.split(fname)[1])[0] + ".xml")
        with open(ofname, "wb") as ofh:
            ofh.write(sertree)


def add_to_xml_out(troot, fname, ini_sents, sente,
                   lemma_position,
                   phrase_head_ids,
                   phrase_token_ids, phrase_token_words,
                   new_xml=False):
    # add these infos once per xml
    if new_xml:
        etree.SubElement(troot, "fileName").text = fname
        first_sents = etree.SubElement(troot, "firstSentences")
        first_sents.text = ini_sents
        examples_ele = etree.SubElement(troot, "examples")
    # add examples as they occur
    examples_ele = troot.findall(".//examples")[0]
    cur_example = etree.SubElement(examples_ele, "example")
    etree.SubElement(cur_example, "sentRaw").text = \
        " ".join([word.form for word in sente])
    etree.SubElement(cur_example, "sentWithTokenPosition").text = \
        " ".join(["{}~{}".format(word.form, word.id) for word in sente])
    etree.SubElement(cur_example, "verbLemmaPosition").text = lemma_position
    etree.SubElement(cur_example, "complementHeadPositions").text = \
        " ".join(phrase_head_ids)
    etree.SubElement(cur_example, "complementTokenPositions").text = \
        " ".join(phrase_token_ids)
    etree.SubElement(cur_example, "complementTokens").text = \
        " ".join(phrase_token_words)


def ana_dir(idir, lemma, deprel):
    """
    Run ana_file on a directory.
    """
    odir= idir + "_caedo-obl"
    if not os.path.exists(odir):
        os.makedirs(odir)
    for fname in sorted(os.listdir(idir)):
        ffname = os.path.join(idir, fname)
        print("# ==", fname , "==\n")
        ana_file(ffname, lemma, deprel, odir)


def _print_dbg_infos(outer_list, inner_list):
    """To print some debug infos"""
    print("- Idlist: ", "^".join(outer_list))
    print("- Length: ", len(outer_list))
    print("- Deps0: ", "~".join(inner_list))


if __name__ == "__main__":
    DBG = False
    if False:
        input_dir = sys.argv[1]
        lemma_to_search = sys.argv[2]
        rel_to_search = sys.argv[3]
    input_dir = "perseus_conll_proiel"
    lemma_to_search = "caedo"
    rel_to_search = "obl"
    ana_dir(input_dir, lemma_to_search, rel_to_search)
    
