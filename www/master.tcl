#
# sloan specifc master
#

# if we have a portal_id show navbar
if {![empty_string_p $portal_id] && ![exists_and_not_null no_navbar_p]} {
#    if {[portal::page_count -portal_id $portal_id] > 1} {
        set navbar "<table border=0 cellpadding=5><tr>"

        append navbar [portal::list_pages -portal_id $portal_id -link "switch-page" -pre_html "<td><font face=arial,helvetica size=-1 color=black><b> <center>" -separator " </center></td> <td><font face=arial,helvetica size=-1 color=black><b> <center>" -post_html "</a></center></td>"]

        append navbar "</tr></table>"
#    } else {
#        set navbar ""
#    }
} else {
    set navbar ""
}

set user_id [ad_verify_and_get_user_id]

db_0or1row pvt_home_user_info {
    select first_names, last_name
    from cc_users
    where user_id=:user_id
}

set full_name "$first_names $last_name"
set title "$full_name : MySloanSpace"

if {[ad_parameter community_level_p] == 1} {
    # in a community
    set text [dotlrn_community::get_community_name [dotlrn_community::get_community_id]]

} elseif {[ad_parameter community_type_level_p] == 1} {
    # in a community type
    set text [dotlrn_community::get_community_type_name [dotlrn_community::get_community_type]]
} else {
    # under /dotlrn
    set text $full_name
}
