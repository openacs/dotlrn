# /dotlrn/www/admin/one-instance-portal-template-2.tcl
ad_page_contract {
    Form target for the Configuration page for an instance's portal template

    @author Arjun Sanyal (arjun@openforce.net)
    @cvs-id $Id$
} { }

set form [ns_getform]
set portal_id [ns_set get $form portal_id]

set user_id [ad_conn user_id]

portal::template_configure_dispatch $portal_id $form

ns_returnredirect "one-instance-portal-template?portal_id=$portal_id"

