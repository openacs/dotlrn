
ad_page_contract {

    @author Hamilton Chua (hamilton.chua@gmail.com)
    @creation-date August 8,2005

} {
    {reset:optional}
    {reltype:optional}
}

set community_id [dotlrn_community::get_community_id]
set page_title "Remove Members"

set rel_types [dotlrn_community::get_roles -community_id $community_id]
foreach role $rel_types {
	if { [string equal $reltype [lindex $role 0]] } { 
		set role_shortname [lang::util::localize [lindex $role 0]]
		set role_prettyname [lang::util::localize [lindex $role 2]] 
	}
}