ad_page_contract {
    @author yon (yon@openforce.net)
    @creation-date 2002-01-30
    @version $Id$
} -query {
    {section ""}
} -properties {
    user_id:onevalue
}

set user_id [ad_conn user_id]

ad_return_template
