
#
# Procs for DOTLRN basic system
# Copyright 2001 OpenForce, inc.
# Distributed under the GNU GPL v2
#
# August 18th, 2001
#

ad_library {
    
    Procs for basic dotLRN
    
    @author ben@openforce.net
    @creation-date 2001-08-18
    
}

namespace eval dotlrn {

    ad_proc install {
    } {
	Does some installation that cannot be done in SQL
    } {
	db_transaction {
	    # Create the rel types
	    rel_types::new -supertype membership_rel -role_two admin admin_rel "Administration Relation" "Administration Relations" dotlrn_community 0 "" party 0 ""
	    rel_types::new -supertype membership_rel -role_two student student_rel "Student Relation" "Student Relations" dotlrn_community 0 "" party 0 ""
	    rel_types::new -supertype admin_rel -role_two admin instructor_rel "Instructor Relation" "Instructor Relations" dotlrn_community 0 "" party 0 ""
	    rel_types::new -supertype admin_rel -role_two admin ta_rel "TA Relation" "TA Relations" dotlrn_community 0 "" party 0 ""
	    
	    # Add what's permissible (we would do this in SQL if the above could be done in SQL...)
	    rel_types::add_permissible dotlrn_class admin_rel
	    rel_types::add_permissible dotlrn_class student_rel
	    rel_types::add_permissible dotlrn_class ta_rel
	    rel_types::add_permissible dotlrn_class instructor_rel

	    rel_types::add_permissible dotlrn_club admin_rel
	    # rel_types::add_permissible dotlrn_club membership_rel
	}
    }


    ad_proc -public class_group_type_key {
    } {
	Returns the group type key used for class groups
    } {
	return [ad_parameter class_group_type_key]
    }

    ad_proc -public group_type_key {
    } {
	Returns the group_type key that is being used for class management
    } {
	return [ad_parameter group_type_key]
    }

}
