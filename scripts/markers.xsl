<xsl:stylesheet version="3.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xpath-default-namespace="http://www.tei-c.org/ns/1.0" xmlns:txm="http://textometrie.org/1.0"
    xmlns:wop="www.unil.ch" exclude-result-prefixes="#all">
    <xsl:output method="xml" indent="yes"/>
    <xsl:mode on-no-match="shallow-copy"/>
    <xsl:variable name="mod_verbs" select="('oporteo', 'licet_est', 'debeo', 'decet', 'possum', 'nequeo', 'queo', 'valeo', 'volo', 'nolo')"/>
    <xsl:variable name="mod_phrases_esse" select="('aequum', 'necesse', 'opus', 'ius|jus', 'iustus|justus')"/>
    <xsl:template match="w">
        <xsl:variable name="pre_esse" select="preceding-sibling::w[1][txm:ana[@type eq '#lalemma'] eq 'sum']"/>
        <xsl:variable name="post_esse" select="following-sibling::w[1][txm:ana[@type eq '#lalemma'] eq 'sum']"/>
        <xsl:variable name="auxiliar" select="txm:ana[@type eq '#lalemma'] = ('habeo', 'sum')"/>
        <xsl:variable name="post_inf" select="following-sibling::w[1][txm:ana[@type eq '#lapos'] eq 'V:INF']"/>
        <xsl:choose>
            
            <!--   1) (C) modal and semimodal verbs expressing possibility, necessity, ability and volition: debeo, decet, licet, (ne)queo, oportet, possum, valet, volo et nolo;         -->
            
            
            <xsl:when
                test="txm:ana[@type eq '#lalemma'] = $mod_verbs and txm:ana[@type eq '#lapos']/matches(., '^V:')">
                <xsl:element name="marker" namespace="www.unil.ch">
                    <xsl:value-of select="txm:form"/>
                </xsl:element>
            </xsl:when>
            
            
            <!--   2) (C) modal phrases with the verb esse expressing necessity and deontic (evaluative) modality: aequum est, meum est, ius est, necesse est, opus est, usus est-->
            
            <xsl:when test="current()[$post_esse]/txm:ana[@type eq '#lalemma'] = $mod_phrases_esse">
                <xsl:element name="marker" namespace="www.unil.ch">
                    <xsl:value-of select="concat(txm:form, ' ', $post_esse/txm:form)"/>
                </xsl:element>
            </xsl:when>
            <xsl:when test="current()[$pre_esse]/txm:ana[@type eq '#lalemma'] = $mod_phrases_esse">
                <xsl:element name="marker" namespace="www.unil.ch">
                    <xsl:value-of select="concat($pre_esse/txm:form, ' ', txm:form)"/>
                </xsl:element>
            </xsl:when>
            
            <!--  3) (C) est + infinitive and habeo + infinitive constructions which express possibility and necessity; -->
            
            <xsl:when test="current()[$auxiliar]/$post_inf">
                <xsl:element name="marker" namespace="www.unil.ch">
                    <xsl:value-of select="concat(txm:form, ' ', $post_inf/txm:form)"/>
                </xsl:element>
            </xsl:when>
            
            <xsl:otherwise>
                <xsl:value-of select="txm:form"/>
            </xsl:otherwise>
            
        </xsl:choose>
    </xsl:template>
    
    
<!--    Correction of previously tagged components -->
    
    <xsl:template match="w[following-sibling::w[1][txm:ana[@type eq '#lalemma'] = $mod_phrases_esse]]"/>
    <xsl:template match="w[preceding-sibling::w[1][txm:ana[@type eq '#lalemma'] = $mod_phrases_esse]]"/>
</xsl:stylesheet>
