<master src="master">
<property name="title">Users Search</property>
<property name="context_bar">@context_bar@</property>

<p></p>

<if @is_request@ ne 0>
  <formtemplate id="user_search"></formtemplate>
</if>
<else>
  <if @n_users@ gt 0>
    <formtemplate id="user_search_results"></formtemplate>
  </if>
  <else>
    <p>
      Your search returned no results, please broaden your search criteria.
    </p>
  </else>
</else>
