<master src="master">
<property name="title">Terms</property>
<property name="context_bar">@context_bar@</property>

[ <a href="term-new">new term</a> ]

<p></p>

<if @terms:rowcount@ gt 0>
<multiple name="terms">
  <include src="term" term_id="@terms.term_id@"
                      term_name="@terms.term_name@"
                      term_year="@terms.term_year@"
                      start_date="@terms.start_date@"
                      end_date="@terms.end_date@">
  <p></p>
</multiple>
</if>

<if @terms:rowcount@ gt 10>
[ <a href="term-new">new term</a> ]
</if>
