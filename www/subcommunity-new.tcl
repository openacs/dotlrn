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

set parent_community_id [dotlrn_community::get_community_id]

set title "New [ad_parameter subcommunity_pretty_name]"

form create add_subcomm

element create add_subcomm subcomm_key \
    -label "[ad_parameter subcommunity_pretty_name] Key (a short name, no spaces)" \
    -datatype text \
    -widget text \
    -html {size 60}

element create add_subcomm pretty_name \
    -label "Name" \
    -datatype text \
    -widget text \
    -html {size 60}

element create add_subcomm description \
    -label "Description (Text or HTML)" \
    -datatype text \
    -widget text \
    -html {size 60}

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
        subcomm_key pretty_name join_policy referer description

    # we set some extra vars based on the community_type of the parent
    set parent_type  \
            [dotlrn_community::get_community_type_from_community_id \
            $parent_community_id]
    set extra_vars [ns_set create]

#    ad_return_complaint 1 "pt $parent_type"

    if {$parent_type == "dotlrn_community"} {
        # we want to make a subcomm of a subcomm
        # nothing for now
    } elseif {$parent_type != [dotlrn_club::community_type]} {
        # we want to make a subgroup of a class instance
        # get the term_id, since the subgroup should not outlive the class
        set term_id [dotlrn_class::get_term_id \
                -class_instance_id $parent_community_id]
        
        ns_set put $extra_vars term_id $term_id
    } 

    ns_set put $extra_vars join_policy $join_policy

    db_transaction {
        set subcomm_id [dotlrn_community::new \
                -parent_community_id $parent_community_id \
                -description $description \
                -community_type "dotlrn_community" \
                -community_key $subcomm_key \
                -pretty_name $pretty_name \
                -extra_vars $extra_vars]
        

        # let admins of the parent comm, be admins
        set parent_admin_segment_id [dotlrn_community::get_rel_segment_id \
                -community_id $parent_community_id \
                -rel_type "dotlrn_admin_rel"]

        # granting admin privs to the admins of the parent comm over the subcomm
        ad_permission_grant $parent_admin_segment_id $subcomm_id admin

        # for a subcomm of a "class" set the start and end dates
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

    ad_returnredirect $referer
    ad_script_abort
}

ad_return_template
