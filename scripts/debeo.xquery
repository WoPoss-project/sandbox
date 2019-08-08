declare namespace tei = "http://www.tei-c.org/ns/1.0";
declare namespace txm = "http://textometrie.org/1.0";
declare namespace output = "http://www.w3.org/2010/xslt-xquery-serialization";
declare option output:method "text";
declare variable $corpus := collection('../annotated-texts')//tei:text;
declare variable $w := $corpus//tei:w[txm:ana[@type eq '#lalemma'] eq 'debeo'];
for $debeo in $w
let $form := $debeo/txm:form
let $position := $debeo/position()
let $prev := for $i in 1 to 10 return $debeo/preceding-sibling::tei:w[$i]
let $prev_context := string-join($prev/txm:form, ' ')
let $next := for $i in 1 to 10 return $debeo/following-sibling::tei:w[$i]
let $next_context := string-join($next/txm:form, ' ')
let $work := $debeo/ancestor::tei:TEI/descendant::tei:title[1]/string-join(.//txm:form, ' ')
let $section := $debeo/ancestor::tei:div2[@type eq 'section']/@n 
let $section2:= $debeo/ancestor::tei:div[@subtype eq 'section']/@n
let $locus := concat($work, '; section ', $section, $section2)
return
    $locus || '&#9;' || $form || '&#9;' || $prev_context ||  '&#9;'  || $form || '&#9;'|| $next_context ||  '&#10;'