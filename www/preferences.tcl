
ad_page_contract {
    Preferences for dotLRN
    
    @author Ben Adida (ben@openforce.net)
    @creation-date 2001-11-10
} {
}

# Make sure user is logged in
set user_id [ad_maybe_redirect_for_registration]

form create preferences

element create preferences theme_id \
	-label "Portal Theme" -datatype text -widget select

if {[form is_valid preferences]} {
    template::form get_values preferences theme_id

    dotlrn::set_user_theme $user_id $theme_id
    ad_returnredirect "./"
    return
} else {
    db_1row select_prefs {}

    element set_properties preferences theme_id -set_value $theme_id
}

ad_return_template
