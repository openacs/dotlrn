
ad_page_contract {
    Displays a configuration page for the main portal
    
    @author Ben Adida (ben@openforce.net)
    @author Arjun Sanyal (arjun@openforce.net)
    @creation-date 2001-11-08
} {
}

set user_id [ad_conn user_id]

# Pull out the NPP page ID and render it!
set page_id [dotlrn_community::get_workspace_page_id $user_id]

# Get the portal's name for the title
set name [portal::get_name $page_id]

set rendered_page [portal::configure $page_id]

set context_bar {Configure}

ad_return_template

