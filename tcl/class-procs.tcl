
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

    ad_proc -public community_type {} {
        returns the base community type for classes
    } {
        return "dotlrn_class_instance"
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

    ad_proc -public get_url_part {} {
        returns the url part for this community type
    } {
        return "classes"
    }

    ad_proc -public get_url {} {
        returns the url part for this community type
    } {
        return "/[get_url_part]"
    }

    ad_proc -public is_initialized {} {
        is dotlrn_class initialized with the right community_type?
    } {
        dotlrn_community::is_initialized -community_type [community_type]
    }

    ad_proc -public init {} {
        create base community_type for dotlrn_clubs
    } {
        dotlrn_community::init \
            -community_type [community_type] \
            -community_type_url_part [get_url_part]
    }

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
        {-term:required}
        {-year:required}
        {-join_policy "needs approval"}
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
        ns_set put $extra_vars join_policy $join_policy

        set pretty_name "[dotlrn_community::get_community_type_name $class_type]; $term $year"

        # Create the community
        return [dotlrn_community::new \
                -description $description \
                -community_type $class_type \
                -object_type [community_type] \
                -community_key $community_key \
                -pretty_name $pretty_name \
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

    ad_proc -public add_user {
        {-rel_type "dotlrn_student_rel"}
        {-community_id:required}
        {-user_id:required}
    } {
        Assigns a user to a particular role for that class. Roles in DOTLRN can be student, prof, ta, admin
    } {
        db_transaction {
            set extra_vars [ns_set create]
            ns_set put $extra_vars class_instance_id $community_id

            dotlrn_community::add_user_to_community -rel_type $rel_type -extra_vars $extra_vars -community_id $community_id -user_id $user_id
        }
    }

    ad_proc -public pretty_name {
        {-class_key:required}
    } {
        gets the pretty name for a particular class
    } {
        return [db_string select_class_pretty_name {} -default ""]
    }
}
