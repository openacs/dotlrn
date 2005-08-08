<master>
<property name="title">@page_title@</property>
<property name="context">"@page_title@"</property>

<p>Are you sure you want to delete all members with the role @role_prettyname;noquote@ ?
<br /><br />
<input type="button" value="Yes" onClick="window.location='members?reset=1&reltype=@role_shortname@'">&nbsp;<input type="button" value="No" onClick="javascript: history.go(-1)">