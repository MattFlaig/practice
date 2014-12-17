<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" >

<xsl:template match="/">
  <html>
  <body>
  <table style="font:18px 'Nunito', sans-serif;border:1px solid black">
    <tr>
      <th style="text-align:center;padding:4px">Name</th>
      <th style="text-align:center;padding:4px">Price</th>
      <th style="text-align:center;padding:4px">Duration</th>
      <th style="text-align:center;padding:4px">Description</th>
      <th style="text-align:center;padding:4px">Teacher</th>
    </tr>
    <xsl:for-each select="edv_courses/course">
    <tr>
      <td><xsl:value-of select="name" /></td>
      <td><xsl:value-of select="price" /></td>
      <td><xsl:value-of select="duration" /></td>
      <td><xsl:value-of select="description" /></td>
      <td><xsl:value-of select="teacher" /></td>
    </tr>
    </xsl:for-each>
  </table>
  </body>
  </html>
</xsl:template>

</xsl:stylesheet> 
