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
        return [ad_parameter dotlrn_main_portlet_pretty_name]
    }

    ad_proc -public link {
    } {
        return ""
    }

    ad_proc -public add_self_to_page { 
        {-page_id ""}
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
        set element_id [portal::add_element \
                -page_id $page_id \
                -force_region 2 \
                $portal_id [my_name]]

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
        # no return call required with the helper proc
        portal::show_proc_helper \
                -template_src "dotlrn-main-portlet" \
                -package_key "dotlrn" \
                -config_list $cf
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
