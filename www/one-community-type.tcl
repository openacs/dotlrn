ad_page_contract {
    Displays a community type

    @author Ben Adida (ben@openforce.net)
    @author yon (yon@openforce.net)
    @creation-date 2001-10-04
    @version $Id$
} -query {
} -properties {
    context_bar:onevalue
    pretty_name:onevalue
    description:onevalue
    supertype:onevalue
    community_type:onevalue
    ancestor_type:onevalue
    community_type_title:onevalue
    communities_title:onevalue
    title:onevalue
}
set portal_id ""

# Check that this is a community type
if {[ad_parameter community_type_level_p] != 1} {
    ad_returnredirect "./"
    ad_script_abort
}

set user_id [ad_conn user_id]

set context_bar {View}

# What community type are we at?
set community_type [dotlrn_community::get_community_type]
set ancestor_type [dotlrn_community::get_toplevel_community_type -community_type $community_type]

# Load some community type info
db_1row select_community_type_info {}

if {[string equal ${community_type} "dotlrn_class_instance"] != 0} {
    set community_type_title [ad_parameter classes_pretty_plural]
    set communities_title "[ad_parameter classes_pretty_name] Instances"
    set title [ad_parameter classes_pretty_plural]
} elseif {[string equal ${community_type} "dotlrn_club"] != 0} {
    set community_type_title [ad_parameter clubs_pretty_plural]
    set communities_title [ad_parameter clubs_pretty_plural]
    set title [ad_parameter clubs_pretty_plural]
} elseif {[string equal ${ancestor_type} "dotlrn_class_instance"] != 0} {
    set community_type_title [ad_parameter classes_pretty_plural]
    set communities_title "[ad_parameter classes_pretty_name] Instances"
    set title $pretty_name
} else {
    set community_type_title "Community Types"
    set communities_title "Communities"
    set title "Community Type"
}

ad_return_template
