#
# sloan specifc master
#




# if we have a portal_id show navbar
set user_id [ad_verify_and_get_user_id]

if {![info exists link_all]} {
    set link_all 0
}

if {![info exists return_url]} {
    set return_url ""
}

if {![info exists show_control_panel]} {
    set show_control_panel 0
}

if {![info exists link_control_panel]} {
    set link_control_panel 1
}

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
    
    if {[info exists portal_id] && ![empty_string_p $portal_id] && ![exists_and_not_null no_navbar_p]} {
        set navbar "<table border=0 cellpadding=5><tr>"
        
        append navbar [portal::list_pages -link_all $link_all -return_url $return_url -portal_id $portal_id -link "switch-page" -pre_html "<td><font face=arial,helvetica size=-1 color=black><b> <center>" -separator " </center></td> <td><font face=arial,helvetica size=-1 color=black><b> <center>" -post_html "</a></center></td>"]
        if {$show_control_panel} {
            if {$link_control_panel} {
                append navbar "<td><font face=arial,helvetica size=-1 color=black><b><center><a href=one-community-admin>Group Admin</a></center></td> </tr></table>"
            } else {
                append navbar "<td><font face=arial,helvetica size=-1 color=black><b><center>Group Admin</center></td> </tr></table>"
            }
        }
        
    } else {
        set navbar ""
        set portal_id ""
    }
    
} elseif {[ad_parameter community_type_level_p] == 1} {
    # in a community type
    set text [dotlrn_community::get_community_type_name [dotlrn_community::get_community_type]]
    
    if {[info exists portal_id] && ![empty_string_p $portal_id] && ![exists_and_not_null no_navbar_p]} {
        set navbar "<table border=0 cellpadding=5><tr>"
        
        append navbar [portal::list_pages -link_all $link_all -return_url $return_url -portal_id $portal_id -link "switch-page" -pre_html "<td><font face=arial,helvetica size=-1 color=black><b> <center>" -separator " </center></td> <td><font face=arial,helvetica size=-1 color=black><b> <center>" -post_html "</a></center></td>"]
        
        append navbar "</tr></table>"
        
    } else {
        set navbar ""
        set portal_id ""
    }
    
} else {
    # under /dotlrn
    set text $full_name
    if {[info exists portal_id] && ![empty_string_p $portal_id] && ![exists_and_not_null no_navbar_p]} {
        set navbar "<table border=0 cellpadding=5><tr>"
        
        append navbar [portal::list_pages -return_url $return_url -portal_id $portal_id -link_all $link_all -link "switch-page" -pre_html "\n<td><font face=arial,helvetica size=-1 color=black><b> <center>" -separator " </center></td>\n<td><font face=arial,helvetica size=-1 color=black><b> <center>" -post_html "</a></center></td>\n"]
        
        if {$link_control_panel} {
            append navbar "<td><font face=arial,helvetica size=-1 color=black><b><center><a href=preferences>Control Panel</a></center></td> </tr></table>"
        } else {
            append navbar "<td><font face=arial,helvetica size=-1 color=black><b><center>Control Panel</center></td> </tr></table>"
        }
        
    } else {
        set navbar ""
        set portal_id ""
    }
}
