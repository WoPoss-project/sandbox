declare namespace tei =  "http://www.tei-c.org/ns/1.0";
declare namespace txm = "http://textometrie.org/1.0";
declare namespace output = "http://www.w3.org/2010/xslt-xquery-serialization";
declare option output:method "text";
declare variable $corpus := collection('OVID_annotations')//tei:text;
declare variable $w := $corpus//tei:w[txm:ana[@type eq '#lapos'] eq 'V:GED'];
for $adj in $w
let $form := $adj/txm:form
let $lemma := $adj/txm:ana[@type eq '#lalemma']
let $lineN := $adj/parent::tei:l/@n
let $line := $adj/parent::tei:l/string-join(./tei:w/txm:form, ' ')
let $bookN := $adj/ancestor::tei:div[@subtype eq 'book']/@n
let $book := if (string-length($bookN) gt 0) then concat('Book ', $bookN) else ()
let $poemN := $adj/ancestor::tei:div[@subtype eq 'poem']/@n
let $poem := if (string-length($poemN) gt 0) then concat(' Poem ', $poemN) else ()
let $parN := count($adj/parent::tei:l/preceding-sibling::tei:milestone[@unit eq 'para'])
let $par := if ($parN gt 0) then concat(' Par. ', $parN) else ()
let $work := $adj/ancestor::tei:text/preceding-sibling::tei:teiHeader/tei:fileDesc/tei:titleStmt/tei:title[1]/string-join(.//tei:w/txm:form, ' ')
return
$work || '&#9;' || $book || $poem || $par || ' Line ' || $lineN || '&#9;' || $form || '&#9;' || $lemma || '&#9;' || $line ||'&#10;'
