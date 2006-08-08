# packages/dotlrn/tcl/dotlrn-callback-procs.tcl

ad_library {
    
    Callback Procedures offered by the .LRN package
    
    @author Malte Sussdorff (sussdorff@sussdorff.de)
    @creation-date 2005-07-19
    @arch-tag: 8a447ef7-85b1-4ef9-b342-49ca78f57e49
    @cvs-id $Id$
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

ad_proc -callback dotlrn::default_member_email {
    -community_id
    -type
    {-to_user ""}
    {-var_list ""}
} {
    Used to define a default email body message for member emails if
    an email template is not found for community_id,type in
    dotlrn_email_templates

    @param community_id dotlrn community_id sending email
    @param to_user user_id to send email to
    @param type type of email from dotlrn_email_templates table

    @return should return a 3 element list of from_addr subject
            email_body. If no email exists, should return -code
            continue to return no results to the caller
    
} -

ad_proc -callback dotlrn::member_email_var_list {
    -community_id
    -type
    {-to_user ""}
} {
    
    @return list of varname value pairs to pass to an email template
} -

ad_proc -callback dotlrn::member_email_available_vars {
    -type
    {-community_id ""}
} {
    @return list of varname description pairs suitable for
    display in the user interface so an editor of an email template will know what variables are available
    description can contain HTML and will be shown with noquote
} -

ad_proc -callback dotlrn_community::add_members {
    -community_id
} {
    This callback will allow other packages to add members to a community
} -

ad_proc -public -callback contact::person_new -impl dotlrn_user {
    {-package_id:required}
    {-contact_id:required}
    {-party_id:required}
} {
    Callback to add an organization's employee to dotLRN.
    It also registers all employees of the organization within the club
} {
    
    
    db_1row get_community_id { }
    
    
    dotlrn_privacy::set_user_guest_p -user_id $party_id -value "t"
    dotlrn::user_add -can_browse  -user_id $party_id
    dotlrn_community::add_user_to_community -community_id $community_id -user_id $party_id
    
    
    
    
}