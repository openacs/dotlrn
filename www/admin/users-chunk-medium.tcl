ad_page_contract {
    @author yon (yon@openforce.net)
    @creation-date 2002-01-30
    @version $Id$
} -query {
    {section ""}
} -properties {
    user_id:onevalue
    control_bar:onevalue
    users:multirow
}

set user_id [ad_conn user_id]
set dotlrn_package_id [dotlrn::get_package_id]
set root_object_id [acs_magic_object "security_context_root"]

if {![exists_and_not_null type]} {
    set type admin
}

if {![exists_and_not_null referer]} {
    set referer "/dotlrn/admin/users"
}

set default_section Z
foreach dimension {A B C D E F G H I J K L M N O P Q R S T U V W X Y Z} {
    if {[string equal $type "deactivated"] == 1} {
        set section_count [db_string select_deactivated_users_count {}]
    } elseif {[string equal $type "pending"] == 1} {
        set section_count [db_string select_non_dotlrn_users_count {}]
    } else {
        set section_count [db_string select_dotlrn_users_count {}]
    }

    if {[empty_string_p $section] && $section_count} {
        set section $dimension
    }

    lappend dimensions [list $dimension $dimension {} $section_count]
}

set control_bar [portal::dimensional [list [list section {} $section $dimensions]]]

if {[string equal $type "deactivated"] == 1} {
    db_multirow users select_deactivated_users {}
} elseif {[string equal $type "pending"] == 1} {
    db_multirow users select_non_dotlrn_users {}
} else {
    db_multirow users select_dotlrn_users {}
}

ad_return_template
