# dotlrn/tcl/club-procs.tcl
#
# procedures for dotlrn clubs
# copyright 2001 openforce, inc
# distributed under the gnu gpl v2
#
# december 3, 2001

ad_library {
    procs to manage dotlrn clubs

    @author yon@openforce.net
    @creation-date 2001-12-03
}

namespace eval dotlrn_club {

    ad_proc -public community_type {} {
        return the community type
    } {
        return "dotlrn_club"
    }

    ad_proc -public get_url_part {} {
        return the url part for this community type
    } {
        return "clubs"
    }

    ad_proc -public get_url {} {
        return the url part for this community type
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
            -pretty_name [ad_parameter -package_id [dotlrn::get_package_id] clubs_pretty_plural]
    }

    ad_proc -public new {
        {-key:required}
        {-pretty_name:required}
        {-description ""}
        {-join_policy "open"}
        {-parent_community_id ""}
    } {
        creates a new club and returns the club key
    } {
        set extra_vars [ns_set create]
        ns_set put $extra_vars join_policy $join_policy

        return [dotlrn_community::new \
            -community_type [community_type] \
            -object_type [community_type] \
            -community_key $key \
            -pretty_name $pretty_name \
            -description $description \
            -parent_community_id $parent_community_id \
            -extra_vars $extra_vars]
    }

    ad_proc -public available_roles {} {
        returns the available roles
    } {
        return {
            {admin_rel "Administrator"}
            {member_rel "Member"}
        }
    }

    ad_proc -public add_user {
        {-rel_type "dotlrn_member_rel"}
        {-community_id:required}
        {-user_id:required}
    } {
        Assigns a user to a particular role for that club.
    } {
        db_transaction {
            dotlrn_community::add_user_to_community -rel_type $rel_type -community_id $community_id -user_id $user_id
        }
    }
}
