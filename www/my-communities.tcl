# dotlrn/www/my-communities.tcl

ad_page_contract {
    @author yon (yon@openforce.net)
    @creation-date Dec 07, 2001
    @version $Id$
} -query {
} -properties {
    communities:multirow
}

set user_id [ad_maybe_redirect_for_registration]
set user_can_browse_p [dotlrn::user_can_browse_p]

if {![info exists referer]} {
    set referer "my-communities"
}

db_multirow communities select_my_communities {}

ad_return_template
