<master src="master">
<property name="title">Spam Community</property>
<property name="context_bar">@context_bar@</property>
<property name="portal_id">@portal_id@</property>
<property name="show_control_panel">1</property>
<property name="control_panel_text">Group Admin</property>
<property name="link_control_panel">1</property>

<formtemplate id="spam_message"></formtemplate>

<blockquote>
  <table>
    <tr>
      <th colspan=3>The following variables can be used to insert user/community specific data:</th>
    </tr>

    <tr>
      <td>&#60sender_email&#62</td>
      <td> = </td>
      <td>Sender's Email Address</td>
    </tr>

<!--
    <tr>
      <td>&#60sender_first_names&#62</td>
      <td> = </td>
      <td>Sender's First Name</td>
    </tr>

    <tr>
      <td>&#60sender_last_name&#62</td>
      <td> = </td>
      <td>Sender's Last Name</td>
    </tr>
-->

    <tr>
      <td>&#60community_name&#62</td>
      <td> = </td>
      <td>Community's Name</td>
    </tr>

    <tr>
      <td>&#60community_url&#62</td>
      <td> = </td>
      <td>Community's Web Address</td>
    </tr>

    <tr>
      <td>&#60email&#62</td>
      <td> = </td>
      <td>Recepient's Email</td>
    </tr>

    <tr>
      <td>&#60first_names&#62</td>
      <td> = </td>
      <td>Recepient's First Name</td>
    </tr>

    <tr>
      <td>&#60last_name&#62</td>
      <td> = </td>
      <td>Recepient's Last Name</td>
    </tr>
  </table>
</blockquote>
