<master src="dotlrn-admin-master">
<property name="title">Terms</property>
<property name="context_bar">@context_bar@</property>

[<small><a href="term-new">New Term</a></small>]

<p></p>

<if @terms:rowcount@ gt 0>
<table width="100%">
  <tr>
    <th align="left" width="15%">Term</th>
    <th align="left" width="15%">Start Date</th>
    <th align="left" width="15%">End Date</th>
    <th align="left" width="15%">Number of Classes</th>
  </tr>
<multiple name="terms">
  <tr>
    <td><a href="term?term_id=@terms.term_id@">@terms.term_name@ @terms.term_year@</a></td>
    <td>@terms.start_date@</td>
    <td>@terms.end_date@</td>
    <td>@terms.n_classes@</td>
  </tr>
</multiple>
</table>
</if>

<if @terms:rowcount@ gt 10>
[<small><a href="term-new">New Term</a></small>]
</if>
