<?xml version="1.0" encoding="UTF-8"?>

<xsl:stylesheet version="1.0"
xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<xsl:template match="/">
	<html>
	 	<head><title> It Works! </title></head>
	 	<body>
		<xsl:apply-templates />
		</body>
	</html>
</xsl:template>

<xsl:template match="ptitle">
		<h2><xsl:apply-templates /></h2>
</xsl:template>

<xsl:template match="ulist">
		<ul><xsl:apply-templates /></ul>
</xsl:template>

<xsl:template match="olist">
		<ol><xsl:apply-templates /></ol>
</xsl:template>

<xsl:template match="item">
		<li><xsl:apply-templates /></li>
</xsl:template>

</xsl:stylesheet>