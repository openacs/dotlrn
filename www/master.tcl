#
# sloan specifc master
#

set user_id [ad_verify_and_get_user_id]

#
# here's a bunch of stuff that an adp _may_ set to alter
# this templates behavior
#

if {[exists_and_not_null portal_id]} {
    set have_portal_id 1
} else {
    set have_portal_id 0 
}

if {[exists_and_not_null no_navbar_p]} {
    set show_navbar_p 0
} else {
    set show_navbar_p 1 
}

if {![info exists link_all]} {
    set link_all 0
}

if {![info exists return_url]} {
    set link [ad_conn -get extra_url]
} else {
    set link $return_url
}

if {![info exists show_control_panel]} {
    set show_control_panel 0
}

if {![info exists link_control_panel]} {
    set link_control_panel 1
}

if {![info exists control_panel_text]} {
    set control_panel_text "Control Panel"
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

    # The header text is the name of the community
    set text [dotlrn_community::get_community_name [dotlrn_community::get_community_id]]

#    ad_return_complaint 1 "foobar $have_portal_id, $show_navbar_p, $link_control_panel, $show_control_panel"

    if { $have_portal_id && $show_navbar_p } {
        if {$show_control_panel} {
            if {$link_control_panel} {
                set extra_td_html "<font face=arial,helvetica size=-1><b> <a href=one-community-admin> $control_panel_text</a></b></font>"
            } else {
                set extra_td_html "<font face=arial,helvetica size=-1><b> $control_panel_text</b></font>"
            }
        } else {
            # don't show control panel
            set extra_td_html ""
        }
            
            set navbar [portal::navbar \
                    -portal_id $portal_id \
                    -link_all $link_all \
                    -link $link \
                    -pre_html "<font face=arial,helvetica size=-1><b>" \
                    -post_html "</b></font>" \
                    -extra_td_html $extra_td_html \
                    -table_html_args "border=0 cellpadding=5"]
    } else {
        set navbar ""
        set portal_id ""
    }
} elseif {[ad_parameter community_type_level_p] == 1} {
    # in a community type
    set text \
            [dotlrn_community::get_community_type_name [dotlrn_community::get_community_type]]
    
    if {$have_portal_id && $show_navbar_p} {
        
           set navbar [portal::navbar \
                   -portal_id $portal_id \
                   -link_all $link_all \
                   -link $link \
                   -pre_html "<font face=arial,helvetica size=-1><b>" \
                   -post_html "</b></font>" \
                   -extra_td_html $extra_td_html \
                   -table_html_args "border=0 cellpadding=5"]
    } else {
        set navbar ""
        set portal_id ""
    }
 
} else {
    # under /dotlrn
    set text $full_name
    
    if {$have_portal_id && $show_navbar_p} {
        if {$link_control_panel} {
            set extra_td_html "<font face=arial,helvetica size=-1><b> <a href=preferences>Control Panel</a></b></font>"
        } else {
            set extra_td_html "<font face=arial,helvetica size=-1><b> Control Panel</b></font>"
        }

        set navbar [portal::navbar \
                -portal_id $portal_id \
                -link_all $link_all \
                -link $link \
                -pre_html "<font face=arial,helvetica size=-1><b>" \
                -post_html "</b></font>" \
                -extra_td_html $extra_td_html  \
                -table_html_args "border=0 cellpadding=5 cellspacing=2"]
    } else {
        set navbar ""
        set portal_id ""
    }
}
