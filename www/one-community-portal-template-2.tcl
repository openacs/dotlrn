# /dotlrn/www/admin/one-instance-portal-template-2.tcl
ad_page_contract {
    Form target for the Configuration page for an instance's portal template

    @author Arjun Sanyal (arjun@openforce.net)
    @version $Id$
} -query {
}

set form [ns_getform]
set portal_id [ns_set get $form portal_id]
set return_url [ns_set get $form return_url]

set user_id [ad_conn user_id]

portal::template_configure_dispatch $portal_id $form

ns_returnredirect "one-community-portal-template?portal_id=$portal_id&return_url=$return_url"

