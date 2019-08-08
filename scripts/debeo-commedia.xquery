declare namespace tei = "http://www.tei-c.org/ns/1.0";
declare namespace txm = "http://textometrie.org/1.0";
declare namespace output = "http://www.w3.org/2010/xslt-xquery-serialization";
declare option output:method "text";
declare variable $corpus := collection('../plautus_annotated/selected')//tei:text;
declare variable $w := $corpus//tei:w[txm:ana[@type eq '#lalemma'] eq 'debeo'];
for $debeo in $w
let $form := $debeo/txm:form
let $lineN := $debeo/ancestor::tei:l/@n
let $line := $debeo/ancestor::tei:l/string-join(./descendant::tei:w/txm:form, ' ')
let $prev_context := $debeo/ancestor::tei:l/preceding-sibling::tei:l[1]/string-join(./tei:w/txm:form, ' ')
let $next_context := $debeo/ancestor::tei:l/following-sibling::tei:l[1]/string-join(./tei:w/txm:form, ' ')
let $work := $debeo/ancestor::tei:TEI/descendant::tei:title[1]/tei:w[1]/txm:form
let $act := $debeo/ancestor::tei:div[@subtype eq 'act']/@n
let $scene := $debeo/ancestor::tei:div[@subtype eq 'scene']/@n
let $locus := concat($work, ': act ', $act, ', scene ', $scene, ', l. ', $lineN)
return
    $locus || '&#9;' || $form || '&#9;' || $prev_context || '&#9;' || $line || '&#9;' || $next_context ||  '&#10;'
