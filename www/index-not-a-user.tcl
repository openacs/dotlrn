# dotlrn/www/index-not-a-user.tcl

ad_page_contract {
    @author yon (yon@milliped.com)
    @creation-date Dec 11, 2001
    @version $Id$
} -query {
} -properties {
    admin_p:onevalue
    admin_url:onevalue
    portal_id:onevalue
}

set admin_p [dotlrn::admin_p]
set admin_url [dotlrn::get_url]/admin

ad_return_template
