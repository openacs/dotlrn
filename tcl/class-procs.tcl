#
# Procs for DOTLRN Class Management
# Copyright 2001 OpenForce, inc.
# Distributed under the GNU GPL v2
#
# August 18th, 2001
#

ad_library {
    Procs to manage DOTLRN Classes

    @author Ben Adida (ben@openforce.net)
    @author yon (yon@openforce.net)
    @creation-date 2001-08-18
    @version $Id$
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
            -community_type_url_part [get_url_part] \
            -pretty_name [ad_parameter -package_id [dotlrn::get_package_id] classes_pretty_plural]
    }

    ad_proc -public new {
        {-class_key:required}
        {-department_key:required}
        {-pretty_name:required}
        {-description ""}
    } {
        Creates a new class, like "Structure and Interpretation of Computer Programs."
        The return value is the short class name, a key that works in SQL, and that uniquely
        identifies the class.

        This class can then be instantiated for a particular semester.
    } {
        db_transaction {
            set class_key [dotlrn_community::new_type \
                -community_type_key $class_key \
                -parent_type $department_key \
                -pretty_name $pretty_name \
                -description $description]

            db_dml insert_class {}
        }
    }

    ad_proc -public new_instance {
        {-class_key:required}
        {-term_id:required}
        {-pretty_name ""}
        {-description ""}
        {-join_policy "closed"}
    } {
        Creates a new instance of a class for a particular term and year,
        and returns the class instance key.
    } {
#        dotlrn_term::get_term_info -term_id $term_id -term_name_var "term" -term_year_var "year"
        set term [dotlrn_term::get_term_name -term_id $term_id]
        set year [dotlrn_term::get_term_year -term_id $term_id]
        set community_key "${class_key}-${term}-${year}"

        set extra_vars [ns_set create]
        ns_set put $extra_vars term_id $term_id
        ns_set put $extra_vars class_key $class_key
        ns_set put $extra_vars join_policy $join_policy

        if {[empty_string_p $pretty_name]} {
            set pretty_name "[dotlrn_community::get_community_type_name $class_key]; $term $year"
        }

        db_transaction {
            # Create the community
            set community_id [dotlrn_community::new \
                    -description $description \
                    -community_type $class_key \
                    -object_type [community_type] \
                    -community_key $community_key \
                    -pretty_name $pretty_name \
                    -extra_vars $extra_vars]

            dotlrn_community::set_active_dates \
                -community_id $community_id \
                -start_date [dotlrn_term::get_start_date -term_id $term_id] \
                -end_date [dotlrn_term::get_end_date -term_id $term_id]
        }

        return $community_id
    }

    ad_proc -public available_roles {
    } {
        Returns the available roles
    } {
        return {
            {instructor_rel "Professor"}
            {aa_rel "Course Assistant"}
            {ta_rel "Teaching Assistant"}
            {student_rel "Student"}
            {admin_rel "Administrator"}
        }
    }

    ad_proc -public add_user {
        {-rel_type "dotlrn_student_rel"}
        {-community_id:required}
        {-user_id:required}
        {-member_state "approved"}
    } {
        Assigns a user to a particular role for that class. Roles in DOTLRN can be student, prof, ta, admin
    } {
        set extra_vars [ns_set create]
        ns_set put $extra_vars class_instance_id $community_id

        dotlrn_community::add_user_to_community \
            -rel_type $rel_type \
            -extra_vars $extra_vars \
            -community_id $community_id \
            -user_id $user_id \
            -member_state $member_state
    }

    ad_proc -public pretty_name {
        {-class_key:required}
    } {
        gets the pretty name for a particular class
    } {
        return [db_string select_class_pretty_name {} -default ""]
    }

    ad_proc -public get_term_id {
        {-class_instance_id:required}
    } {
        get the term_id for this class instance
    } {
        return [db_string get_term_id {}]
    }

    ad_proc -public get_term_name {
        {-class_instance_id:required}
    } {
        get the term for this class instance
    } {
        return [dotlrn_term::get_term_name -term_id [get_term_id -class_instance_id $class_instance_id]]
    }

    ad_proc -public get_term_year {
        {-class_instance_id:required}
    } {
        get the term year for this class instance
    } {
        return [dotlrn_term::get_term_year -term_id [get_term_id -class_instance_id $class_instance_id]]
    }

    ad_proc -public can_create {
    } {
        can a class be created? essentially, does at least one department
        exist?
    } {
        return [db_string can_create {}]
    }

    ad_proc -public can_instantiate {
        {-class_key:required}
    } {
        can this class be instantiated?
    } {
        return [db_string can_instantiate {}]
    }

}
