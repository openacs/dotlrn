# dotlrn/www/admin/site-wide-admin-toggle.tcl

ad_page_contract {
    @author yon (yon@openforce.net)
    @creation-date Jan 12, 2002
    @version $Id$
} -query {
    user_id
    value
    {referer "users"}
}

if {[string equal $value "grant"] == 1} {
    ad_permission_grant $user_id [acs_magic_object "security_context_root"] "admin"
} elseif {[string equal $value "revoke"] == 1} {
    ad_permission_revoke $user_id [acs_magic_object "security_context_root"] "admin"
}

ad_returnredirect $referer
