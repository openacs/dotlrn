<master src="./master">
<property name="title">dotLRN Clubs</property>
<property name="context_bar">@context_bar@</property>

<ul>
  <multiple name="clubs">
    <li><a href=club?club_id=@clubs.club_id@>@clubs.pretty_name@</a></li>
  </multiple>
  <p>
  <li><a href=club-new>Create Club</a></li>
</ul>
