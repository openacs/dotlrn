# packages/dotlrn/tcl/dotlrn-callback-procs.tcl

ad_library {
    
    Callback Procedures offered by the .LRN package
    
    @author Malte Sussdorff (sussdorff@sussdorff.de)
    @creation-date 2005-07-19
    @arch-tag: 8a447ef7-85b1-4ef9-b342-49ca78f57e49
    @cvs-id $Id$
}

ad_proc -public -callback contact::contact_form -impl dotlrn_club {
    {-package_id:required}
    {-form:required}
    {-object_type:required}
    {-party_id}
    {-group_ids ""}
} {
    Callback to hook into the contacts system. If you create a new
    organization of the group "Customer" within contacts you generate
    a new .LRN club for it (assuming that each organization contacts
    deserves it's own club.			    
} {
    if {$object_type != "person" } {
	
	set already_linked_p "f"
	if {[exists_and_not_null party_id]} {

	    # if we are in edit mode we need to make that we are not
	    # already linked to a community
	    if {[application_data_link::get_linked -from_object_id $party_id -to_object_type "dotlrn_club"] != ""} {
		set already_linked_p "t"
	    }
	}
	
	if {$already_linked_p == "f"} {
	    if {[lsearch $group_ids [group::get_id -group_name "Customers"]] > -1} {
		ad_form -extend -name $form -form {
		    {create_club_p:text(hidden) \
			 {value "t"}
		    }
		}
	    }
	}
    }
}

ad_proc -public -callback contact::organization_new -impl dotlrn_club {
    {-package_id:required}
    {-contact_id:required}
    {-name:required}
} {
    Callback to create a new club for a new organization in Contacts.
    It also registers all employees of the organization within the club
} {
    upvar create_club_p create_club_p
    
    if {[exists_and_not_null create_club_p]
	&& $create_club_p == "t"} {
	# Create the new club and create a link between it and
	# the new contact.

	set club_id [dotlrn_club::new -pretty_name "$name"]
	application_data_link::new -this_object_id $contact_id -target_object_id $club_id

	# Link the file storage directly to the contact
	set fs_id [fs::get_root_folder -package_id [dotlrn_community::get_package_id_from_package_key -package_key "file-storage" -community_id $club_id]]
	application_data_link::new -this_object_id $contact_id -target_object_id $fs_id

	# Get list of employees and register them within the community
	set employee_list [contact::util::get_employees -organization_id $contact_id]
	foreach employee_id $employee_list {
	    dotlrn_club::add_user -community_id $club_id -user_id $employee_id
	}
    }
}

ad_proc -callback merge::MergeShowUserInfo -impl dotlrn {
    -user_id:required
} {
    Show dotlrn items 	
} {
    set msg "dotLRN items for $user_id"
    ns_log Notice $msg
    set result [list $msg]
    
    set from_rel_ids [db_list_of_lists get_from_rel_ids { *SQL* } ]	    
    
    foreach rel $from_rel_ids {
	set l_rel_id [lindex $rel 0]
	set l_rel_type [lindex $rel 1]
	set l_community_id [lindex $rel 2]
	
	lappend result [list "This user has the rel_type : $l_rel_type in community_id : $l_community_id" ] 
    }
    
    return $result
}

ad_proc -callback merge::MergePackageUser -impl dotlrn {
    -from_user_id:required
    -to_user_id:required
} {
    Merge the dotlrn items of two users.
    The from_user_id is the user_id of the user
    that will be deleted and all the dotlrn elements
    of this user will be mapped to to_user_id.
    
} {
    ns_log Notice "Merging dotlrn"

    db_transaction {
	
	# select the communities where from_user_id belongs to and
	# to_user_id does not belong.
	set from_rel_ids [db_list_of_lists get_from_rel_ids { *SQL* } ]	    
	
	foreach rel $from_rel_ids {
	    set l_rel_id [lindex $rel 0]
	    set l_rel_type [lindex $rel 1]
	    set l_community_id [lindex $rel 2]
	    
	    # Add to_user_id to the communities
	    # where from_user_id is with the same role
	    # Add the relation
	    dotlrn_community::add_user -rel_type $l_rel_type $l_community_id $to_user_id

	}

	# remove the user
	dotlrn::user_remove -user_id $from_user_id
	
	set result ".LRN merge is done"
    } 
    
    return $result
}