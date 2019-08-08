declare namespace tei = "http://www.tei-c.org/ns/1.0";
declare namespace txm = "http://textometrie.org/1.0";
declare namespace output = "http://www.w3.org/2010/xslt-xquery-serialization";
declare option output:method "text";
declare variable $corpus := collection('../annotated-texts/digiliblt')//tei:text;
(:declare variable $caedere := $corpus//tei:w[txm:ana[@type eq '#lalemma'] = 'caedo'][not(contains(txm:ana[@type eq '#lapos'], 'V:PTC'))];:)
(:passive:)
declare variable $caedere := $corpus//tei:w[txm:ana[@type eq '#lalemma'] = 'caedo']
[contains(txm:ana[@type eq '#lapos'], 'V:PTC')];
for $kw in $caedere
(:where $kw[parent::tei:s[tei:w[txm:ana[@type eq '#lapos']/contains(., ':acc')]]] and 
$kw[parent::tei:s[tei:w[txm:ana[@type eq '#lapos']/contains(., ':abl')]]]:)
(:passive:)
where $kw[parent::tei:s[tei:w[txm:ana[@type eq '#lapos']/contains(., ':abl')]]] and
$kw[parent::tei:s[tei:w[txm:ana[@type eq '#lalemma']/contains(., 'ESSE')]]]
let $form := $kw/txm:form
let $prev := for $i in 1 to 10 return $kw/preceding-sibling::tei:w[$i]
let $prev_context := string-join($prev/txm:form, ' ')
let $next := for $i in 1 to 10 return $kw/following-sibling::tei:w[$i]
let $next_context := string-join($next/txm:form, ' ')
let $file := $kw/ancestor::tei:text/preceding-sibling::tei:teiHeader/descendant::tei:title[1]
return
    $file || '&#9;' || $prev_context || ' ' || $form || ' ' || $next_context ||  '&#10;'