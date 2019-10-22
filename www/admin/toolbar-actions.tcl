ad_page_contract {

} {
    action:notnull
    {search_type ""}
    {keyword ""}
    {return_url:localurl "[dotlrn::get_admin_url]"}
} -validate {
    if_search {
        if { $action eq "search" && ( $search_type eq "" || $keyword eq "" ) } {
            ad_complain "If you want to search please type some keyword and in where to search"
        }
    }
    if_not_admin {
        if { ![acs_user::site_wide_admin_p] && ![dotlrn::admin_p] } {
            ad_complain "Not authorized to do toolbar actions"
        }
    }
}

switch -- $action {
    "search" {
        switch $search_type {
            "departments" {
                set return_url [export_vars -base "/dotlrn/admin/departments" {keyword}]
            }
            "subjects" {
                set return_url [export_vars -base "/dotlrn/admin/classes" {keyword}]
            }
            "classes" {
                set return_url [export_vars -base "/dotlrn/admin/term" {keyword {term_id "-1"}}]
            }
            default {
                set return_url [export_vars -base "/dotlrn/admin/users-search" {{name $keyword} {form\:id "user_search"}}]
            }
        }
    }
    "hide" {
        parameter::set_value -package_id [dotlrn::get_package_id] -parameter dotlrn_toolbar_enabled_p -value 0
    }
    "show" {
        parameter::set_value -package_id [dotlrn::get_package_id] -parameter dotlrn_toolbar_enabled_p -value 1
    }
    "info_hide" {
        parameter::set_value -package_id [dotlrn::get_package_id] -parameter dotlrn_toolbar_show_info_p -value 0
    }
    "info_show" {
        parameter::set_value -package_id [dotlrn::get_package_id] -parameter dotlrn_toolbar_show_info_p -value 1
    }
}

ad_returnredirect $return_url
ad_script_abort

# Local variables:
#    mode: tcl
#    tcl-indent-level: 4
#    indent-tabs-mode: nil
# End:
