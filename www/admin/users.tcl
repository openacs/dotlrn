ad_page_contract {
    Displays the admin users page

    @author yon (yon@openforce.net)
    @creation-date 2002-01-30
    @version $Id$
} -query {
    {type "admin"}
} -properties {
    context_bar:onevalue
    control_bar:onevalue
    n_users:onevalue
}

set context_bar {Users}

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
