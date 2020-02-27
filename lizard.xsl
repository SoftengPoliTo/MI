<?xml version="1.0"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
 
  <xsl:template match="build">
      <xsl:value-of select="build/message" disable-output-escaping="yes"/>
  </xsl:template>
  <xsl:output method="html" indent="yes"/>
 
  <xsl:template match="cppncss">
    <html>
      <body>
      <table>
        <div class="app">
          <div class="h3">
            <h3>Summary</h3>
            <p>Report generated by
              <a href="https://github.com/terryyin/lizard">lizard</a>.</p>
          </div>
          <xsl:apply-templates select="measure[@type='Function']" mode="summary"/>  

          <xsl:apply-templates select="measure[@type='Function']" mode="fcc"/>  
         
        </div>
        </table>
      </body>
    </html>
  </xsl:template>
 
 
    <xsl:template match="measure[@type='Function']" mode="fcc">
    <div class="h4">
      <h4>Function Code Complexity: </h4>
      <table border="1" width="100%" cellspacing="2" cellpadding="3">
        <tr>    
          <th>Function CC</th>
          <th>Function lines</th>
          <th>Function and File</th>
        </tr>
        <xsl:for-each select="item">
          <xsl:sort data-type="number" order="descending"  select="value[3]"/>
 <xsl:if test="number(value[3]) >= number(15)">
          <tr>
            <td>
              <xsl:value-of select="value[3]"/>
            </td>
            <td>
              <xsl:value-of select="value[2]"/>
            </td>
            <td>
              <xsl:value-of select="@name"/>
            </td>
          </tr>
 </xsl:if>
        </xsl:for-each>
      </table>
    </div>
  </xsl:template>
 

  <xsl:template match="measure[@type='Function']" mode="summary">
    <table border="1" width="100%" cellspacing="2" cellpadding="3">
      <tr class="a">
        <td>Average Function Cyclomatic Complexity</td>
        <td>
         <xsl:value-of select="format-number(sum(item/value[3]) div count(item), '#.##')"/>
        </td>
      </tr>
      <tr class="b">
        <td>Average Function lines of code without comments</td>
        <td><xsl:value-of select="format-number(sum(item/value[2]) div count(item), '#.##')"/></td>
      </tr>

    </table>
  </xsl:template>


</xsl:stylesheet>