<master src="dotlrn-master">
<property name="title">dotLRN</property>

You are a member of the following groups:
<ul>
<%
foreach community $communities {
        set url [lindex $community 5]
        set pretty_name [lindex $community 3]

        template::adp_puts "<li> <a href=\"$url\">$pretty_name</a>\n"
}
%>
</ul>




