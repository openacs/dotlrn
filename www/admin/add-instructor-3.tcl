# dotlrn/www/admin/add-instructor-3.tcl

ad_page_contract {
    @author yon (yon@openforce.net)
    @creation-date Jan 10, 2002
    @version $Id$
} -query {
    user_id:integer,notnull
    community_id:integer,notnull
    {referer ""}
}

set is_dotlrn_user [db_string is_dotlrn_user {}]

# if the user isn't already a dotLRN user make him so
if {!${is_dotlrn_user}} {
    dotlrn::user_add -type "professor" -access_level "full" -user_id $user_id
    acs_privacy::set_user_read_private_data -user_id $user_id -object_id [dotlrn_community::get_package_id $community_id] -value "t"
}

# Add the relation
dotlrn_community::add_user -rel_type "dotlrn_instructor_rel" $community_id $user_id

ad_returnredirect $referer
