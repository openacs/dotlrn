# dotlrn/www/dotlrn-main-portlet-procs.tcl
ad_page_contract {
    The display logic for the dotlrn main (Groups) portlet

    @author Arjun Sanyal (arjun@openforce.net)
    @cvs_id $Id$
}

array set config $cf        

set user_id [ad_get_user_id]
set list_of_communities [dotlrn_community::get_all_communities_by_user $user_id]
set my_community_id [lindex $list_of_communities 0]

db_multirow -local communities select_communities "   
select dotlrn_communities.community_id,
dotlrn_communities.community_type,
dotlrn_communities.community_key,
dotlrn_communities.pretty_name,
dotlrn_communities.package_id
from dotlrn_communities,
dotlrn_member_rels_full
where dotlrn_communities.community_id = dotlrn_member_rels_full.community_id
and dotlrn_member_rels_full.user_id = :user_id" {
#    ad_return_complaint 1 "aks [info locals] ${communities(package_id)}"
    set communities(url) [dotlrn_community::get_url_from_package_id -package_id ${communities(package_id)} ]
}

ad_return_template
