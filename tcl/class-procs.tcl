
#
# Procs for DOTLRN Class Management
# Copyright 2001 OpenForce, inc.
# Distributed under the GNU GPL v2
#
# August 18th, 2001
#

ad_library {
    
    Procs to manage DOTLRN Classes
    
    @author ben@openforce.net
    @creation-date 2001-08-18
    
}

namespace eval dotlrn_class {

    ad_proc -public new {
	{-description ""}
	{-class_key:required}
	{-pretty_name:required}
	{-parent_type "dotlrn_class_instance"}
    } {
	Creates a new class, like "Structure and Interpretation of Computer Programs."
	The return value is the short class name, a key that works in SQL, and that uniquely
	identifies the class.

	This class can then be instantiated for a particular semester.
    } {
	db_transaction {
	    # create the community type
	    set class_key [dotlrn_community::new_type \
		    -description $description \
		    -community_type_key $class_key \
		    -parent_type $parent_type \
		    -pretty_name $pretty_name]

	    # insert the class row (this would be much easier if object types were objects, too - ben)
	    db_dml insert_class {}
	}
    }

    ad_proc -public new_instance {
	{-description ""}
	{-class_type:required}
	{-class_name:required}
	{-term:required}
	{-year:required}
    } {
	Creates a new instance of a class for a particular term and year,
	and returns the class instance key.
    } {
	set term [string trim $term]
	set year [string trim $year]

	set community_key "$class_type-$term-$year"

	set extra_vars [ns_set create]
	ns_set put $extra_vars year $year
	ns_set put $extra_vars term $term
	ns_set put $extra_vars class_key $class_type
	
	# Create the community
	return [dotlrn_community::new \
		-description $description \
		-community_type $class_type \
		-object_type dotlrn_class_instance \
		-community_key $community_key \
		-pretty_name $class_name \
		-extra_vars $extra_vars]
    }

    ad_proc -public available_roles {
    } {
	Returns the available roles
    } {
	return {
	    {instructor_rel "Instructor"}
	    {ta_rel "Teaching Assistant"}
	    {student_rel "Student"}
	    {admin_rel "Administrator"}
	}
    }

    ad_proc -public package_key {
    } {
	Returns the package key for this package
    } {
	return "dotlrn"
    }

    ad_proc -public one_class_package_key {
    } {
	Returns the package key for this package
    } {
	return "dotlrn"
    }

}
