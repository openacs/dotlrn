# dotlrn/www/preferences.tcl

ad_page_contract {
    Preferences for dotLRN

    @author Ben Adida (ben@openforce.net)
    @author yon (yon@openforce.net)
    @creation-date 2001-11-10
    @version $Id$
} -query {
} -properties {
    title:onevalue
    admin_p:onevalue
    admin_url:onevalue
    referer:onevalue
}

set portal_id [dotlrn::get_workspace_portal_id [ad_get_user_id]]

# Make sure user is logged in
set user_id [ad_maybe_redirect_for_registration]

set title "Preferences"
set admin_p [dotlrn::admin_p]
set admin_url "[dotlrn::get_url]/admin"
set referer [ns_conn url]

ad_return_template
