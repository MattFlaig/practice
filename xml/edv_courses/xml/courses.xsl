<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" >

<xsl:template match="/">
  <html>
  <body style="border:none">
  <div style="margin-left:auto;margin-right:auto;text-align: center;max-width: 800px;border-radius: 5px;-moz-border-radius: 5px-webkit-border-radius: 5px;overflow: hidden;">
  <table style="font:18px 'Nunito', sans-serif;max-width: 800px; margin-left:auto;margin-right:auto;">
    <tr>
      <th style="text-align:center;padding:4px;font: 25px 'Nunito', sans-serif;padding: 10px 10px 10px 10px;border-bottom: 1px solid navy;color: #fff;background-color: navy">Name</th>
      <th style="text-align:center;padding:4px;font: 25px 'Nunito', sans-serif;padding: 10px 10px 10px 10px;border-bottom: 1px solid navy;color: #fff;background-color: navy">Price</th>
      <th style="text-align:center;padding:4px;font: 25px 'Nunito', sans-serif;padding: 10px 10px 10px 10px;border-bottom: 1px solid navy;color: #fff;background-color: navy">Duration</th>
      <th style="text-align:center;padding:4px;font: 25px 'Nunito', sans-serif;padding: 10px 10px 10px 10px;border-bottom: 1px solid navy;color: #fff;background-color: navy">Description</th>
      <th style="text-align:center;padding:4px;font: 25px 'Nunito', sans-serif;padding: 10px 10px 10px 10px;border-bottom: 1px solid navy;color: #fff;background-color: navy">Teacher</th>
    </tr>
    <xsl:for-each select="edv_courses/course">
    <tr>
      <td style="padding: 20px;text-align:center;"><xsl:value-of select="name" /></td>
      <td style="padding: 20px;text-align:center;"><xsl:value-of select="price" /></td>
      <td style="padding: 20px;text-align:center;"><xsl:value-of select="duration" /></td>
      <td style="padding: 20px;text-align:center;"><xsl:value-of select="description" /></td>
      <td style="padding: 20px;text-align:center;"><xsl:value-of select="teacher" /></td>
    </tr>
    </xsl:for-each>
  </table>
  </div>
  </body>
  </html>
</xsl:template>

</xsl:stylesheet> 
