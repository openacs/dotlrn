<master src="master">
<property name="title">@pretty_name@</property>
<property name="context_bar">@context_bar@</property>

<p>
  @description@
</p>

<p>
<if @can_instantiate@ gt 0>
  [ <a href="class-instance-new?class_key=@class_key@">New <%= [ad_parameter class_instances_pretty_name] %></a> ]
</if>
<else>
<include src="need-term-note">
</else>
</p>

<table bgcolor="#ececec" width="100%">
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
<table width="100%">
  <tr>
    <th align="left" width="15%">Term</th>
    <th align="left" width="50%"><%= [ad_parameter class_instances_pretty_name] %> Name</th>
    <th align="left">Actions</th>
  </tr>
<multiple name="class_instances">
  <tr>
    <td><a href="term?term_id=@class_instances.term_id@">@class_instances.term_name@&nbsp;@class_instances.term_year@</a></td>
    <td><a href="@class_instances.url@">@class_instances.pretty_name@</a></td>
    <td>[<small><a href="@class_instances.url@one-community-admin">admin</a></small>]</td>
  </tr>
</multiple>
</table>
</if>
