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
        set community_type [community_type]
        return [db_string is_dotlrn_class_initialized {
            select count(*)
            from dotlrn_community_types
            where community_type = :community_type
            and package_id is not null
        }]
    }

    ad_proc -public init {} {
        create base community_type for dotlrn_clubs
    } {
        db_transaction {
            set dotlrn_clubs_url "[dotlrn::get_url][dotlrn_club::get_url]/"
            if {![dotlrn::is_instantiated_here -url $dotlrn_clubs_url]} {
                set package_id [dotlrn::mount_package \
                    -package_key [dotlrn::package_key] \
                    -url [dotlrn_club::get_url_part] \
                    -directory_p "t"]

                dotlrn_community::set_type_package_id [community_type] $package_id
            }
        }
    }

    ad_proc -public new {
        {-key:required}
        {-pretty_name:required}
        {-description:required}
    } {
        creates a new club and returns the club key
    } {
        return [dotlrn_community::new \
            -community_type [community_type] \
            -object_type [community_type] \
            -community_key $key \
            -pretty_name $pretty_name \
            -description $description]
    }

    ad_proc -public available_roles {} {
        returns the available roles
    } {
        return {
            {admin_rel Administrator}
            {member_rel Member}
        }
    }
}
