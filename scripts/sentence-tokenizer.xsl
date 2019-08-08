<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    exclude-result-prefixes="xs"
    xpath-default-namespace="http://www.tei-c.org/ns/1.0"
    version="2.0">
    <xsl:output method="text"/>
    <!--    Command line:
    java -jar SaxonHE9-9-14J/saxon9he.jar -s:digiliblt sandbox/scripts/sentence-tokenizer.xsl -o:prova
    -->
    <xsl:template match="/">
        <xsl:variable name="uri" select="substring-after(base-uri(.), 'digiliblt/')"/>
        <xsl:result-document href="{replace($uri, '\.xml', '.txt')}">
        <xsl:apply-templates select="//body"/>
        </xsl:result-document>
    </xsl:template>
    <xsl:template match="body">
        <xsl:value-of select="replace(replace(normalize-space(.), '\n', ' '), '[,\.;?!\(\):«»‘’–]', '&#x0000A;')"/>
    </xsl:template>
</xsl:stylesheet>