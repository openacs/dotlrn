<master>
<property name="title">@page_title@</property>
<property name="context">"@page_title@"</property>

<p>@confirm_message;noquote@
<br /><br />
<input type="button" value="Yes" onClick="window.location='@action_url;noquote@'">&nbsp;<input type="button" value="No" onClick="javascript: history.go(-1)">