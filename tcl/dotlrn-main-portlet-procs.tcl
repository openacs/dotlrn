# dotlrn/tcl/dotlrn-main-portlet-procs.tcl

ad_library {

    Procedures to supports dotlrn main portlet

    Copyright Openforce, Inc.
    Licensed under GNU GPL v2 

    @creation-date November 4 2001
    @author ben@openforce.net 
    @version $Id$

}

namespace eval dotlrn_main_portlet {

    ad_proc -private my_name {
    } {
        return "dotlrn_main_portlet"
    }

    ad_proc -public get_pretty_name {
    } {
        return "My Groups"
    }

    ad_proc -public link {
    } {
        return ""
    }

    ad_proc -public add_self_to_page { 
        portal_id 
        instance_id 
    } {
        Adds a dotLRN PE to the given page with the instance key being
        opaque data in the portal configuration.

        @return element_id The new element's id
        @param portal_id The page to add self to
        @param instance_id The bboard instace to show
        @author arjun@openforce.net
        @creation-date Nov 2001
    } {
        # Tell portal to add this element to the page
        set element_id [portal::add_element $portal_id [my_name]]

        return $element_id
    }

    ad_proc -public show { 
        cf 
    } {
        Display the PE

        @return HTML string
        @param cf A config array
        @author ben@openforce.net
        @creation-date Nov 2001
    } {
        array set config $cf        

        set user_id [ad_get_user_id]

        # This is not templated. OH NO. I am a horrible, horrible,
        # little man. (ben)

        set return_html "<table border=0 cellpadding=2 cellspacing=2 width=100%>"
        set communities [dotlrn_community::get_all_communities_by_user $user_id]

        foreach community $communities {
            set url [dotlrn_community::get_url_from_package_id -package_id [lindex $community 4]]
            set name [lindex $community 3]

            append return_html "<tr><td><a href=\"${url}\"><b>${name}</b></a></td></tr>\n"
        }

        if {[dotlrn::user_can_browse_p $user_id]} {
            append return_html "<tr><td><p></p></td></tr>\n"
            append return_html "<tr><td><a href=\"classes\"><small>\[Subscribe to a new class\]</small></a>&nbsp;"
            append return_html "<a href=\"clubs\"><small>\[Subscribe to a new club\]</small></a></td></tr>\n"
        }

        append return_html "</table>"
        return $return_html
    }   

    ad_proc -public edit { 
        cf 
    } {
        return ""
    }

    ad_proc -public remove_self_from_page { 
        portal_id 
        instance_id 
    } {
        Removes a bboard PE from the given page 

        @param portal_id The page to remove self from
        @param instance_id
        @author ben@openforce.net
        @creation-date Nov 2001
    } {
        # get the element IDs (could be more than one!)
        set element_ids [portal::get_element_ids_by_ds $portal_id [my_name]]

        # remove all elements
        db_transaction {
            foreach element_id $element_ids {
                portal::remove_element $element_id
            }
        }
    }
}
