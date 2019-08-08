<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xpath-default-namespace="http://www.tei-c.org/ns/1.0"
    exclude-result-prefixes="xs"
    version="2.0">
    <!--    Command line:
    java -jar SaxonHE9-9-14J/saxon9he.jar -s:perseus_xml scripts/tei2text.xsl -o:plain_text/perseus
    -->
    <xsl:output method="text"/>
    <xsl:template match="/">
        <xsl:variable name="uri" select="substring-after(base-uri(.), 'perseus_xml/')"/>
        <xsl:result-document href="{replace($uri, '\.xml', '.txt')}">
        <xsl:apply-templates select="//titleStmt"/>
        <xsl:apply-templates select="//body"/>
        </xsl:result-document>
    </xsl:template>
    <xsl:template match="body">
        <xsl:value-of select="replace(normalize-space(.), '\n', ' ')"/>
    </xsl:template>
</xsl:stylesheet>