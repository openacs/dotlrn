# 

ad_page_contract {

    update the screen_names of the dotlrn_users

    @author sw (dotlrn@email.wuon.de)
    @creation-date 2005-11-06
    @arch-tag: 65ea921b-7d02-49f3-929a-41be5a174b53
    @cvs-id $Id$

} -query {

return_url

}

ns_log Notice "Start updating the screen_names...\n"
db_foreach get_user_ids "select d.first_names, u.user_id from users u, dotlrn_users d where screen_name is null and u.user_id = d.user_id" {
    set screen_name "[join [split $first_names " "] ""]$user_id"
    db_dml update_screen_name { update users set screen_name = :screen_name where user_id = :user_id }
    ns_log Notice "<li>screenname of user_id '$user_id' was set to '$screen_name'\n"
} if_no_rows {
    ns_log Notice "...there weren't any updates on the screen_names to do\n"
}
ns_log Notice "End updating the screen_names!\n"

ad_returnredirect $return_url
