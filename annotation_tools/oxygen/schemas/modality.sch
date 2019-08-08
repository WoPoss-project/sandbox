<?xml version="1.0" encoding="UTF-8"?>
<schema xmlns="http://purl.oclc.org/dsdl/schematron" queryBinding="xslt2">
   <ns uri="http://www.tei-c.org/ns/1.0" prefix="tei"/>
   <let name="featureIDs" value="''"/>
   <let name="fsIDs" value="''"/>
   <pattern>
      <rule context="@feats">
         <let name="values" value="for $i in tokenize(current(), '\s+') return $i"/>
         <assert test="                             every $value in $values                                 satisfies $value = $featureIDs">One of the values inside the @feats attribute does not match any f/@xml:id of
                        the Feature Structure Declaration</assert>
      </rule>
      <rule context="@fVal">
         <let name="values" value="for $i in tokenize(current(), '\s+') return $i"/>
         <assert test="                         every $value in $values                         satisfies $value = $fsIDs">One of the values inside the @fVal attribute does not match any fs/@xml:id of
                        the Feature Structure Declaration</assert>
      </rule>

      <rule context="tei:fs[not(@feats)][@type eq 'relation']">
         <assert test="if (count(./tei:f) gt 0) then tei:f[@name = ('modality', 'relation')] else true()"> The mandatory features are ''; and the optional ones are
                            'modality', 'relation'. There is a feature in
                        this structure that has not been declared </assert>
      </rule>
      <rule context="tei:f[@name eq 'modality'][parent::fs[@type eq 'relation']]">
         <assert test="tei:fs[@type = ('dynamic', 'deontic', 'epistemic')]"> Incorrect @type value. Possible values are:
                                'dynamic, deontic, epistemic'</assert>
      </rule>
      <rule context="tei:f[@name eq 'relation'][parent::fs[@type eq 'relation']]"/>

      

      <rule context="tei:fs[not(@feats)][@type eq 'marker']">
         <assert test="if (count(./tei:f) gt 0) then tei:f[@name = ('archiunit', 'illocution')] else true()"> The mandatory features are ''; and the optional ones are
                            'archiunit', 'illocution'. There is a feature in
                        this structure that has not been declared </assert>
      </rule>
      <rule context="tei:f[@name eq 'archiunit'][parent::fs[@type eq 'marker']]">
         <assert test="tei:symbol[@value = ('futurity', 'possibility', 'necessity', 'non-modal', 'permission', 'obligation', 'certainty', 'acceptability')]"> Incorrect @type value. Possible values are:
                                'futurity, possibility, necessity, non-modal, permission, obligation, certainty, acceptability'</assert>
      </rule>
      <rule context="tei:f[@name eq 'illocution'][parent::fs[@type eq 'marker']]">
         <assert test="tei:symbol[@value = ('assertive_aff', 'assertive_neg', 'interrogative', 'injuctive', 'exclamative', 'rhetoric', 'pragmatic')]"> Incorrect @type value. Possible values are:
                                'assertive_aff, assertive_neg, interrogative, injuctive, exclamative, rhetoric, pragmatic'</assert>
      </rule>

      <rule context="tei:fs[not(@feats)][@type eq 'scope']">
         <assert test="if (count(./tei:f) gt 0) then tei:f[@name = ('illocution', 'SoA')] else true()"> The mandatory features are ''; and the optional ones are
                            'illocution', 'SoA'. There is a feature in
                        this structure that has not been declared </assert>
      </rule>
      <rule context="tei:f[@name eq 'illocution'][parent::fs[@type eq 'scope']]">
         <assert test="tei:symbol[@value = ('assertive_aff', 'assertive_neg', 'interrogative', 'injuctive', 'exclamative', 'rhetoric', 'pragmatic')]"> Incorrect @type value. Possible values are:
                                'assertive_aff, assertive_neg, interrogative, injuctive, exclamative, rhetoric, pragmatic'</assert>
      </rule>
      <rule context="tei:f[@name eq 'SoA'][parent::fs[@type eq 'scope']]">
         <assert test="tei:fs[@name ='&#xA;                     &#xA;                        &#xA;                           &#xA;                           &#xA;                        &#xA;                     &#xA;                     &#xA;                        &#xA;                           &#xA;                           &#xA;                        &#xA;                     &#xA;                     &#xA;                        &#xA;                           &#xA;                           &#xA;                           &#xA;                        &#xA;                     &#xA;                  ']"> Required fs of type type</assert>
      </rule>







      

      <rule context="tei:fs[not(@feats)][@type eq 'dynamic']">
         <assert test="if (count(./tei:f) gt 0) then tei:f[@name = ('subtype', 'meaning')] else true()"> The mandatory features are ''; and the optional ones are
                            'subtype', 'meaning'. There is a feature in
                        this structure that has not been declared </assert>
      </rule>
      <rule context="tei:f[@name eq 'subtype'][parent::fs[@type eq 'dynamic']]">
         <assert test="tei:symbol[@value = ('participant-inherit', 'participant-imposed', 'situational')]"> Incorrect @type value. Possible values are:
                                'participant-inherit, participant-imposed, situational'</assert>
      </rule>
      <rule context="tei:f[@name eq 'meaning'][parent::fs[@type eq 'dynamic']]">
         <assert test="tei:symbol[@value = ('possibility', 'necessity')]"> Incorrect @type value. Possible values are:
                                'possibility, necessity'</assert>
      </rule>

      

      <rule context="tei:fs[not(@feats)][@type eq 'deontic']">
         <assert test="if (count(./tei:f) gt 0) then tei:f[@name = ('speaker_authority', 'scalarity', 'common_ground', 'compelling_agent', 'meaning')] else true()"> The mandatory features are ''; and the optional ones are
                            'speaker_authority', 'scalarity', 'common_ground', 'compelling_agent', 'meaning'. There is a feature in
                        this structure that has not been declared </assert>
      </rule>
      <rule context="tei:f[@name eq 'speaker_authority'][parent::fs[@type eq 'deontic']]">
         <assert test="tei:symbol[@value = ('obligation', 'recommendation', 'permission')]"> Incorrect @type value. Possible values are:
                                'obligation, recommendation, permission'</assert>
      </rule>
      <rule context="tei:f[@name eq 'scalarity'][parent::fs[@type eq 'deontic']]">
         <assert test="tei:symbol[@value = ('absolutely_necessary', 'desirable', 'acceptable', 'not_desirable', 'unacceptable')]"> Incorrect @type value. Possible values are:
                                'absolutely_necessary, desirable, acceptable, not_desirable, unacceptable'</assert>
      </rule>
      <rule context="tei:f[@name eq 'common_ground'][parent::fs[@type eq 'deontic']]">
         <assert test="tei:binary"> Binary feature.
                        </assert>
      </rule>
      <rule context="tei:f[@name eq 'compelling_agent'][parent::fs[@type eq 'deontic']]"/>
      <rule context="tei:f[@name eq 'meaning'][parent::fs[@type eq 'deontic']]">
         <assert test="tei:symbol[@value = ('intention', 'volition', 'evaluation')]"> Incorrect @type value. Possible values are:
                                'intention, volition, evaluation'</assert>
      </rule>



      

      <rule context="tei:fs[not(@feats)][@type eq 'epistemic']">
         <assert test="if (count(./tei:f) gt 0) then tei:f[@name = ('degree', 'common_ground', 'evidence')] else true()"> The mandatory features are ''; and the optional ones are
                            'degree', 'common_ground', 'evidence'. There is a feature in
                        this structure that has not been declared </assert>
      </rule>
      <rule context="tei:f[@name eq 'degree'][parent::fs[@type eq 'epistemic']]">
         <assert test="tei:symbol[@value = ('absolutely_certain', 'probable', 'possible', 'improbable', 'impossible')]"> Incorrect @type value. Possible values are:
                                'absolutely_certain, probable, possible, improbable, impossible'</assert>
      </rule>
      <rule context="tei:f[@name eq 'common_ground'][parent::fs[@type eq 'epistemic']]">
         <assert test="tei:binary"> Binary feature.
                        </assert>
      </rule>
      <rule context="tei:f[@name eq 'evidence'][parent::fs[@type eq 'epistemic']]">
         <assert test="tei:symbol[@value = ('')] or tei:fs[@type = ('evidential_justification')]"> Incorrect value. Possible values are: a fs element with one of
                    the following @type attributes 'evidential_justification'
                    or a symbol element with one of the following @value attributes ''</assert>
      </rule>



      

      <rule context="tei:fs[not(@feats)][@type eq 'evidential_justification']">
         <assert test="if (count(./tei:f) gt 0) then tei:f[@name = ('perception')] else true()"> The mandatory features are ''; and the optional ones are
                            'perception'. There is a feature in
                        this structure that has not been declared </assert>
      </rule>
      <rule context="tei:f[@name eq 'perception'][parent::fs[@type eq 'evidential_justification']]">
         <assert test="tei:fs[@type = ('direct', 'indirect')]"> Incorrect @type value. Possible values are:
                                'direct, indirect'</assert>
      </rule>

      

      <rule context="tei:fs[not(@feats)][@type eq 'direct']">
         <assert test="if (count(./tei:f) gt 0) then tei:f[@name = ('sense')] else true()"> The mandatory features are ''; and the optional ones are
                            'sense'. There is a feature in
                        this structure that has not been declared </assert>
      </rule>
      <rule context="tei:f[@name eq 'sense'][parent::fs[@type eq 'direct']]">
         <assert test="tei:symbol[@value = ('hearing', 'sight')]"> Incorrect @type value. Possible values are:
                                'hearing, sight'</assert>
      </rule>

      

      <rule context="tei:fs[not(@feats)][@type eq 'indirect']">
         <assert test="if (count(./tei:f) gt 0) then tei:f[@name = ('input')] else true()"> The mandatory features are ''; and the optional ones are
                            'input'. There is a feature in
                        this structure that has not been declared </assert>
      </rule>
      <rule context="tei:f[@name eq 'input'][parent::fs[@type eq 'indirect']]">
         <assert test="tei:symbol[@value = ('inference', 'memory', 'report', 'feeling', 'quotation')]"> Incorrect @type value. Possible values are:
                                'inference, memory, report, feeling, quotation'</assert>
      </rule>
   </pattern>
</schema>
