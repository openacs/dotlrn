<master src="master">
<property name="title">Admin: @pretty_name@</property>
<property name="context_bar">@context_bar@</property>

<ul>

<if @dotlrn_admin_p@ eq 1>
  <li><a href="@dotlrn_admin_url@">dotLRN Administration</a>
</if>

  <p></p>
  <li>
    <a href="one-community-portal-template">Customize This Portal</a>
  </li>

  <p></p>
  <li>
    Membership
    <ul>
      <li><a href="members">Manage Membership</a> - Add/Remove @pretty_name@ members</li>
      <li>
        Change Enrollment Policy
        - <if @join_policy@ eq "closed">closed</if><else><a href="join-policy-toggle?policy=closed">closed</a></else>
        | <if @join_policy@ eq "open">open</if><else><a href="join-policy-toggle?policy=open">open</a></else>
        | <if @join_policy@ eq "needs approval">wait</if><else><a href="join-policy-toggle?policy=needs%20approval">wait</a></else>
      </li>
      <li>
        <a href="user-add?type=student&rel_type=dotlrn_user_rel&read_private_data_p=t">Add a Limited Access user to this community</a>
        - This allows you to register new users and give them access to just this community.
      </li>
      <li>
        <a href="user-add?type=student&rel_type=dotlrn_user_rel&read_private_data_p=f">Add a Limited Access Guest user to this community</a>
        - This allows you to register new non-MIT users and give them access to just this community.
        Information about students who are part of this community will not be available to this user.
      </li>
    </ul>
  </li>

<if @n_subgroups@ gt 0>
  <p></p>
  <li><include src="subgroups"></li>
</if>

  <p></p>
  <li><a href="applets">Manage Applets</a></li>

</ul>
