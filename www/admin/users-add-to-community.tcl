# dotlrn/www/admin/add-users-to-community.tcl

ad_page_contract {
    Add a set of users to a community

    @author yon (yon@openforce.net)
    @creation-date 2002-02-10
    @version $Id$
} -query {
    users
    {referer "users-search"}
} -properties {
    context_bar:onevalue
}

set context_bar {{users Users} {users-search {User Search}} {Add Users to Community}}

form create select_community

element create select_community users \
    -label "&nbsp;" \
    -datatype text \
    -widget hidden \
    -value $users

element create select_community referer \
        -label "Referer" \
        -datatype text \
        -widget hidden \
        -value $referer

set communities [db_list_of_lists select_all_communities {
    select pretty_name, community_id
    from dotlrn_communities
}]

if {[llength $communities]} {
    element create select_community community_id \
        -label "Add to" \
        -datatype text \
        -widget select \
        -options "{{} {}} $communities"
} else {
    element create select_community community_id \
        -label "No communities to add to" \
        -datatype text \
        -widget hidden \
        -value ""
}

if {[form is_valid select_community]} {
    form get_values select_community \
        users community_id

    if {![empty_string_p $community_id]} {
        db_transaction {
            foreach user $users {
                dotlrn_community::add_user $community_id $user
            }
        }
    }

    ad_returnredirect $referer
    ad_script_abort
}

ad_return_template
