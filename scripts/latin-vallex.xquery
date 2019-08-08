declare namespace output = "http://www.w3.org/2010/xslt-xquery-serialization";
declare option output:method "text";
declare option output:encoding "utf-8";
declare variable $file := doc('/db/woposs/latin_vallex.xml');
declare variable $words := //word[matches(@lemma, '[a-z]bil[ei]')];
for $word in $words
let $frame := $word//frame[@status eq 'reviewed']
return        
           <w>{concat($word/@lemma,  '&#x9;' , $word/@POS , '&#x9;' ,
            normalize-space($frame/example) , '&#x9;')}
            {
for $element in $frame/frame_elements/element
            
            return
                
               <s>{concat($element/@functor , '&#x9;' , $element//@type , '&#x9;')}
                   
                    {
                        for $node in $element/form/node
                        return
                            
                            for $at in $node/@*
                            return
                                <n>{concat($at/name(), ' = ', $at, ';')}</n>}
                   
</s>                 
} &#xA;   
</w>
