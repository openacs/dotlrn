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
} {
    Callback to hook into the contacts system. If you create a new
    organization within contacts you are offered the option to create
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
	    ad_form -extend -name $form -form {
		{create_club_p:text(radio) \
		     {label "[_ dotlrn.Create_Club]"} \
		     {options {{[_ acs-kernel.common_Yes] "t"} {[_ acs-kernel.common_no] "f"}}} \
		     {values "f"}
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
    }
}
