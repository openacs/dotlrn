ad_page_contract {
    create a new subcommunity (aks subgroup)

    @author arjun (arjun@openforce.net)
    @creation-date 2001-02-12
    @version $Id$
} -query {
    {referer "one-community-admin"}
} -properties {
    title:onevalue
}

set user_id [ad_get_user_id]
set parent_community_id [dotlrn_community::get_community_id]
set title "New [ad_parameter subcommunity_pretty_name]"
set admin_portal_id \
        [dotlrn_community::get_portal_template_id $parent_community_id]

form create add_subcomm

element create add_subcomm pretty_name \
    -label "Name" \
    -datatype text \
    -widget text \
    -html {size 40}

element create add_subcomm description \
    -label "Description <br> (Text or HTML)" \
    -datatype text \
    -widget text \
    -html {size 40}

element create add_subcomm join_policy \
    -label "Join Policy" \
    -datatype text \
    -widget select \
    -options {{Closed closed} {"Needs Approval" "needs approval"} {Open open}}

element create add_subcomm referer \
    -label "Referer" \
    -datatype text \
    -widget hidden \
    -value $referer

if {[form is_valid add_subcomm]} {
    form get_values add_subcomm \
            pretty_name description join_policy referer 

    # we set some extra vars based on the community_type of the parent
    set parent_type  \
            [dotlrn_community::get_community_type_from_community_id \
            $parent_community_id]

    set extra_vars [ns_set create]
    ns_set put $extra_vars join_policy $join_policy
    
    if {![string equal $parent_type [dotlrn_club::community_type]] &&
        ![string equal $parent_type "dotlrn_community"]} {
            # we want to make a subgroup of a class instance
            # get the term_id, since the subgroup should not
            # outlive the class
            set term_id [dotlrn_class::get_term_id \
                    -class_instance_id $parent_community_id]
        
            ns_set put $extra_vars term_id $term_id
    } 

    db_transaction {
        set subcomm_id [dotlrn_community::new \
                -parent_community_id $parent_community_id \
                -description $description \
                -community_type "dotlrn_community" \
                -pretty_name $pretty_name \
                -extra_vars $extra_vars]
        
        # let admins of the parent comm, be admins of the subcomm
        set parent_admin_segment_id [dotlrn_community::get_rel_segment_id \
                -community_id $parent_community_id \
                -rel_type "dotlrn_admin_rel"]
        ad_permission_grant $parent_admin_segment_id $subcomm_id admin

        # add self as admin
        dotlrn_community::add_user \
                -rel_type "dotlrn_admin_rel" \
                $subcomm_id \
                $user_id

        # for a subcomm of a "class instance" set the start and end dates
        if {![string equal $parent_type [dotlrn_club::community_type]] &&
                 ![string equal $parent_type "dotlrn_community"]} {

                     dotlrn_community::set_active_dates \
                             -community_id $subcomm_id \
                             -start_date \
                             [dotlrn_term::get_start_date -term_id $term_id] \
                             -end_date \
                             [dotlrn_term::get_end_date -term_id $term_id]
        }
    }

    # redirect to the member page of the new sub comm (for adding)
    ad_returnredirect "[dotlrn_community::get_community_key -community_id $subcomm_id]/members?referer=$referer"

    ad_script_abort
}

ad_return_template
