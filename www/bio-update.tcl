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

set page_title [_ dotlrn.Edit_Biography]

if {[empty_string_p $user_id]} {
    set user_id [ad_conn user_id]
}

if { $user_id == [ad_conn user_id] } {
    set context [list [list [ad_pvt_home] [ad_pvt_home_name]] $page_title]
} else {
    set context [list $page_title]
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

ns_log Notice " HAM : $user_id "

if { [exists_and_not_null user_id ] } {
	if { ![acs_user::site_wide_admin_p -user_id [ad_conn user_id] ] } {
		if { $user_id != [ad_conn user_id] } {
			ad_return_forbidden  "Permission Denied"  "<blockquote> You don't have permission to view this page. </blockquote>"
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
    {upload_file:file,optional {label "1. Add your picture"} {help_text "Images should not exceed 50KB.  Images will be scaled to a width of 135 pixels."}}
    {fullname:text(hidden) {value $fullname}}
}

if {![db_0or1row get_item_id {
    select live_revision as revision_id, item_id
    from acs_rels a, cr_items c
    where a.object_id_two = c.item_id
    and a.object_id_one = :user_id
    and a.rel_type = 'user_portrait_rel'
}] || [empty_string_p $revision_id]} {
    # The user doesn't have a portrait yet
    set portrait_p 0
    ad_form -extend -name user_info -form {
        {delete_portrait_p:text(hidden) {value 0}}
    }
} else {
    set portrait_p 1
    ad_form -extend -name user_info -form {
        {delete_portrait_p:text(radio),optional {label "or delete current portrait?"} {options {{Yes 1}}}}
    }
}

ad_form -extend -name user_info -form {
    {bio:richtext(richtext),optional
        {label "2. Add your bio"}
        {html {rows 8 cols 60}}
        {nospell 1}
        {help_text "Cut and paste or type your bio into the following text area."}
    }
    {bio_file:file,optional {label "OR upload a text file"}}
    {bio_file_html_p:text(radio) {label "Upload file format"} {options {{"Plain Text" 0} {"HTML" 1}}} {values 0}}
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
        set bio [template::util::richtext::get_property contents $bio]
        set from_format "text/html"
    }

    set user_info(bio) [ad_html_text_convert -from $from_format -to "text/html" $bio]

    array set result [auth::update_local_account \
                          -authority_id $user(authority_id) \
                          -username $user(username) \
                          -array user_info]


    if {![empty_string_p $upload_file]} {
        set tmp_filename [template::util::file::get_property tmp_filename $upload_file]
        set file_extension [string tolower [file extension $upload_file]]

        # remove the first . from the file extension
        regsub "\." $file_extension "" file_extension

        set guessed_file_type [template::util::file::get_property mime_type $upload_file]

        if {[string equal $guessed_file_type "image/pjpeg"]} {
            set guessed_file_type "image/jpeg"
        }

        set valid_mime_types {"image/jpeg" "image/gif"}

        set n_bytes [file size $tmp_filename]
        
        if {![regexp {([^/\\]+)$} $upload_file match client_filename]} {
            # couldn't find a match
            set client_filename $upload_file
        }

        if {$n_bytes > 51200} {
            set result(update_status) "portrait_error"
            lappend result(element_messages) upload_file
            lappend result(element_messages) "Picture must be 50KB or less"
        } elseif {[lsearch $valid_mime_types $guessed_file_type] == -1} {
            set result(update_status) "portrait_error"
            lappend result(element_messages) upload_file
            lappend result(element_messages) "We only accept gif or jpeg (you uploaded $guessed_file_type)"
        } else {
            if {![db_0or1row get_item_id {
                select object_id_two as item_id
                from acs_rels
                where object_id_one = :user_id
                and rel_type = 'user_portrait_rel'
            }]} {
                db_transaction {
                    set var_list [list \
                                      [list content_type image] \
                                      [list name portrait-of-user-$user_id]]
                    set item_id [package_instantiate_object -var_list $var_list content_item]
                    
                    db_exec_plsql create_rel {
                        select acs_rel__new (
                                             null,
                                             'user_portrait_rel',
                                             :user_id,
                                             :item_id,
                                             null,
                                             null,
                                             null
                                             )
                    }
                }
            }

            set convert_path [parameter::get -parameter ConvertBinPath -package_id [dotlrn::get_package_id] -default "/usr/local/bin/convert"]

            if { [file exists $convert_path] } {
                if { [catch {exec $convert_path -type [lindex [split $guessed_file_type /] 1] -scale 135 $tmp_filename $tmp_filename} errmsg] } {
                    ns_log Warning "\"convert\" failed with the following error: $errmsg"
                }
            }

            set revision_id [cr_import_content \
                                 -image_only \
                                 -item_id $item_id \
                                 -storage_type lob \
                                 -creation_user [ad_conn user_id] \
                                 -creation_ip [ad_conn peeraddr] \
                                 [ad_conn package_id] \
                                 $tmp_filename \
                                 $n_bytes \
                                 $guessed_file_type \
                                 portrait-of-user-$user_id]
            
            item::publish -item_id $item_id -revision_id $revision_id
            
        }
    } else {
        if {![empty_string_p $delete_portrait_p] && $delete_portrait_p} {
            db_foreach get_portrait {
                select object_id_two,
                       rel_id
                from acs_rels
                where object_id_one = :user_id
                and rel_type = 'user_portrait_rel'
            } {
                db_dml update_rev {
                    update cr_items
                    set live_revision = NULL
                    where item_id = :object_id_two
                }
                db_exec_plsql del_rel {
                    select content_item__unrelate(:rel_id)
                }
                content::item::delete -item_id $item_id
            }
        }
    }

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
