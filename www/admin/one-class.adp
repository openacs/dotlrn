<master src="master">
<property name="title">@pretty_name@</property>
<property name="context_bar">@context_bar@</property>

<p>
  @description@
</p>

<p>
<if @can_instantiate@ gt 0>
  [ <a href="class-instance-new?class_key=@class_key@">New <%= [ad_parameter classes_pretty_name] %> Instance</a> ]
</if>
<else>
<include src="need-term-note">
</else>
</p>

<table bgcolor="#ececec" border="0" cellspacing="0" cellpadding="3" width="100%">
  <tr>
    <th align="left" width="50%">
<formtemplate id="term_form">
      Term:&nbsp;<formwidget id="term_id">
</formtemplate>
    </th>
  </tr>
</table>

<p></p>

<if @class_instances:rowcount@ gt 0>
<table border="0" cellspacing="0" cellpadding="3" width="100%">
  <tr>
    <th align="left" width="10%">Term</th>
    <th align="left"><%= [ad_parameter classes_pretty_name] %> Instance Name</th>
  </tr>
<multiple name="class_instances">
  <tr>
    <td>@class_instances.term_name@&nbsp;@class_instances.term_year@</td>
    <td><a href="@class_instances.url@one-community-admin">@class_instances.pretty_name@</a></td>
  </tr>
</multiple>
</table>
</if>
