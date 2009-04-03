ad_page_contract {
    Displays form for currently logged in user to update his/her
    personal information

    @author Unknown
    @creation-date Unknown
    @cvs-id $Id$
} {
    {return_url ""}
    {user_id ""}
}

# HAM : 090705 user must be logged in to view this page
auth::require_login

set doc(title) [_ dotlrn.Edit_Biography]

if {[empty_string_p $user_id]} {
    set user_id [ad_conn user_id]
}

if { $user_id == [ad_conn user_id] } {
    set context [list [list [ad_pvt_home] [ad_pvt_home_name]] $doc(title)]
} else {
    set context [list $doc(title)]
}

if {[empty_string_p $return_url]} {
    set return_url "[acs_community_member_url -user_id $user_id]&community_id=[dotlrn_community::get_community_id]"
}

set focus {}

set form_elms { authority_id username }

# HAM : 090705 do some permission checks here
# - are we given a user_id
# - if yes
# 	check if current user is a site wide admin
#		if not then 
#			check if currently logged in user_id = given user_id
#			if not then
#				show permission denied
# - if no given user_id then get user_id of current logged in user for editing

if { [exists_and_not_null user_id ] } {
	if { ![acs_user::site_wide_admin_p -user_id [ad_conn user_id] ] } {
		if { $user_id != [ad_conn user_id] } {
			ad_return_forbidden  "#dotlrn.Permission_Denied#"  "<p> #dotlrn.You_dont_have_permission_to_view_this_page# </p>"
        		ad_script_abort
		} else {
			acs_user::get -user_id $user_id -array user -include_bio	
		}
	} else {
		acs_user::get -user_id $user_id -array user -include_bio	
	}
} else {
	acs_user::get -user_id [ad_conn user_id] -array user -include_bio	
}

set fullname $user(name)

ad_form -name user_info -html {enctype multipart/form-data} -export {return_url} -form {
    {user_id:integer(hidden)}
    {fullname:text(hidden) {value $fullname}}
    {bio:richtext(richtext),optional
        {label "#dotlrn.Add_your_bio#"}
        {html {rows 8 cols 60}}
        {nospell 1}
        {help_text "[_ dotlrn.Cut_and_paste_or_type_your_bio_]"}
    }
    {bio_file:file,optional {label "#dotlrn.OR_upload_a_text_file#"}}
    {bio_file_html_p:text(radio) {label "#dotlrn.Upload_file_format#"} {options {{"#dotlrn.Plain_Text#" 0} {"#dotlrn.HTML#" 1}}} {values 0}}
} -on_request {
    foreach var { authority_id username } {
        set $var $user($var)
    }
    set bio [template::util::richtext::set_property contents bio $user(bio)]
} -on_submit {
    set user_info(authority_id) $user(authority_id)
    set user_info(username) $user(username)
    foreach elm $form_elms {
        if { [info exists $elm] } {
            set user_info($elm) [string trim [set $elm]]
        }
    }

    if {![empty_string_p $bio_file]} {
        set bio_filename [template::util::file::get_property tmp_filename $bio_file]
        set fd [open $bio_filename]
        set bio "[read $fd]"
        close $fd
        if {$bio_file_html_p} {
            set from_format "text/html"
        } else {
            set from_format "text/plain"
        }
    } else {
        set from_format [template::util::richtext::get_property format $bio]
        set bio [template::util::richtext::get_property contents $bio]
    }

    set user_info(bio) [ad_html_text_convert -from $from_format -to "text/html" $bio]

    array set result [auth::update_local_account \
                          -authority_id $user(authority_id) \
                          -username $user(username) \
                          -array user_info]

    # Handle authentication problems
    switch $result(update_status) {
        ok {
            # Continue below
        }
        default {
            # Adding the error to the first element, but only if there are no element messages
            if { [llength $result(element_messages)] == 0 } {
                form set_error user_info $first_element $result(update_message)
            }
                
            # Element messages
            foreach { elm_name elm_error } $result(element_messages) {
                form set_error user_info $elm_name $elm_error
            }
            break
        }
    }
} -after_submit {
    if { [string equal [ad_conn account_status] "closed"] } {
        auth::verify_account_status
    }
    
    ad_returnredirect $return_url
    ad_script_abort
}
