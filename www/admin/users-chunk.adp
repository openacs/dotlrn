<p>@control_bar@</p>

<if @n_users@ gt 2500>
  <include src="users-chunk-large" type=@type@>
</if>
<else>
  <if @n_users@ gt 100>
    <include src="users-chunk-medium" type=@type@>
  </if>
  <else>
    <include src="users-chunk-small" type=@type@>
  </else>
</else>
