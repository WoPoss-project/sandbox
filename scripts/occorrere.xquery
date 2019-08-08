declare namespace tei = "http://www.tei-c.org/ns/1.0";
declare namespace txm = "http://textometrie.org/1.0";
declare namespace output = "http://www.w3.org/2010/xslt-xquery-serialization";
declare option output:method "text";
declare variable $corpus := collection('bib6')//tei:text;
declare variable $w := $corpus//tei:w[txm:ana[@type eq '#itlemma'] = ('occorrere', 'bisognare')];
for $modal in $w
let $form := $modal/txm:form
let $position := $modal/position()
let $prev := for $i in 1 to 10 return $modal/preceding-sibling::tei:w[$i]
let $prev_context := string-join($prev/txm:form, ' ')
let $next := for $i in 1 to 10 return $modal/following-sibling::tei:w[$i]
let $next_context := string-join($next/txm:form, ' ')
let $work := string-join($modal/ancestor::tei:TEI/descendant::tei:title[1]//txm:form, ' ')
let $date := $modal/ancestor::tei:TEI/descendant::tei:creation/tei:date//txm:form[1]
let $locus := $work
return
    $locus || '&#9;' || $date || '&#9;' || $form || '&#9;' || $prev_context || ' ' || $form || ' ' || $next_context ||  '&#10;'