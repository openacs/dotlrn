ad_page_contract {
    Displays all available communities

    @author yon (yon@openforce.net)
    @creation-date 2002-01-15
    @version $Id$
} -query {
} -properties {
    context_bar:onevalue
}

set portal_id ""
set context_bar {{All Communities}}

ad_return_template
