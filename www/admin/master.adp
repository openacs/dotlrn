<master>
<property name="title">@title@</property>

<table width="100%" border=0 cellspacing=0 cellpadding=2>
  <tr>
    <td align=left colspan=2>
      <table width="100%" border="0" cellpadding="3" cellspacing="0" bgcolor="#FFFFFF">
        <tr bgcolor="#CC0000">
          <td colspan="3" valign="middle">
            <img src="/dotlrn/spacer.gif" width="1" height="2">
          </td>
        </tr>
        <tr>
          <td align="left" valign="middle" bgcolor="#FFFFFF">
            <font face="arial,helvetica" size="+1" color="#000000">dotLRN</font>
          </td>
          <td valign="middle" bgcolor="#FFFFFF" align="right">
            <font face="arial,helvetica" size="+1" color="#000000">MIT Sloan</font>
          </td>
        </tr>
      </table>
    </td>
  </tr>
  <tr bgcolor="#CC0000">
    <td colspan="3" valign="middle">
      <img src="/dotlrn/spacer.gif" width="1" height="2">
    </td>
  </tr>
</table>

<h2>@title@</h2>
  <%= [eval dotlrn::admin_navbar $context_bar] %>
<hr>
<slave>
