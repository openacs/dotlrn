ad_page_contract {
    Displays a community

    @author Ben Adida (ben@openforce.net)
    @author yon (yon@openforce.net)
    @creation-date 2001-10-04
    @version $Id$
} -query {
}


set form [ns_getform]
set portal_id [ns_set get $form portal_id]
set page_id [ns_set get $form page_id]
set return_url [ns_set get $form return_url]

ad_require_permission $portal_id portal_edit_portal

portal::set_current_page -portal_id $portal_id -page_id $page_id

ad_returnredirect $return_url
