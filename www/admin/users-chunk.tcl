ad_page_contract {
    Displays main dotLRN admin page

    @author Ben Adida (ben@openforce.net)
    @creation-date 2001-11-04
} -query {
    {type admin}
} -properties {
    control_bar:onevalue
    n_users:onevalue
}

set control_bar [ad_dimensional {
    {type {User Type:} admin
        {
            {admin Administrators {}}
            {professor Professors {}}
            {student Students {}}
            {pending Pending {}}
        }
    }
}]

if {[string equal $type "pending"] == 1} {
    set n_users [db_string select_non_dotlrn_users_count {}]
} else {
    set n_users [db_string select_dotlrn_users_count {}]
}

ad_return_template
