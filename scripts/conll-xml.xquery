declare namespace output = "http://www.w3.org/2010/xslt-xquery-serialization";
declare option output:method "text";
declare variable $corpus := collection('perseus_conll_proiel_caedo-obl')//file;
let $examples := $corpus//example
return
<a>
{'File' || '&#9;' || 'Title (first lines of file)' || '&#9;' || 'Context' || '&#9;' || 'Verb position' || '&#9;' ||'Ablative construction' || '&#10;'}
{ for $ex in $examples
let $context := $ex/sentRaw
let $file := $ex/ancestor::file/fileName
let $metadata := $ex/ancestor::file/firstSentences
let $dep := $ex/complementTokens
let $pos := $ex/verbLemmaPosition
return
replace($file, 'perseus_conll_proiel/', '') || '&#9;' || $metadata || '&#9;' || $context ||  '&#9;' || $pos || '&#9;' || $dep || '&#10;'} 
</a>