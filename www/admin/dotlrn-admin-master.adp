<master>
<property name="title">@title@</property>

<h2>@title@</h2>

<if @context_bar@ not nil>
  <%= [eval dotlrn::admin_navbar $context_bar] %>
</if>
<hr>
<slave>
