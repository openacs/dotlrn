ad_page_contract {
    Let's the admin change a user's password.
   

    @version $Id$
} {
    {user_id:integer}
    {return_url ""}
    {password_old ""}
} 

#Pages in this directory are only runnable by dotlrn-wide admins.
dotlrn::require_admin 

set context_bar [list [list users Users] [list "user.tcl?user_id=$user_id" "usuario"] "[_ dotlrn.Update_Password]"]

set site_link [ad_site_home_link]

ad_return_template
