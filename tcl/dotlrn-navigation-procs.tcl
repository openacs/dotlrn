
ad_library {
    Procs for navigating dotLRN

    @author ben@openforce
    @creation-date 2002-03-18
}

namespace eval dotlrn_navbar {
    
    ad_proc -public navbar_links {
	{-url ""}
	{-links:required}
    } {
	set list_of_links [list [list [dotlrn::get_url] dotLRN]]

	# Determine if we're in a community
	set community_id [dotlrn_community::get_community_id_from_url -url $url]

	if {![empty_string_p $community_id]} {
	    lappend list_of_links [list [dotlrn_community::get_community_url $community_id] \
		    [dotlrn_community::get_community_name $community_id]]
	}

	set list_of_links [concat $list_of_links $links]

	return $list_of_links
    }

}