ad_page_contract {
    Displays main dotLRN admin page
    
    @author Ben Adida (ben@openforce.net)
    @creation-date 2001-11-04
} -query {
} -properties {
    context_bar:onevalue
    user_id:onevalue
    users:multirow
}

set user_id [ad_conn user_id]

set dotlrn_package_id [dotlrn::get_package_id]

# Currently, just present a list of dotLRN users
db_multirow users select_dotlrn_users {}

set context_bar {Users}

ad_return_template
