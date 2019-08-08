<schema xmlns="http://purl.oclc.org/dsdl/schematron" queryBinding="xslt2">
    <ns prefix="tei" uri="http://www.tei-c.org/ns/1.0"/>
    <let name="featureFile" value="doc('../modality_lib.xml')"/>
    <let name="featureStructures"
        value="$featureFile//tei:fs/@xml:id"/>
    <pattern>
        <rule context="tei:seg">
            <let name="values"
                value="
                for $i in tokenize(@ana, '\s+')
                return
                substring-after($i, '#')"/>
            <assert
                test="
                if (@ana) then
                every $value in $values
                satisfies $value = $featureStructures
                else
                true()"
                >The value of the attribute is not listed</assert>
        </rule>
    </pattern>
</schema>