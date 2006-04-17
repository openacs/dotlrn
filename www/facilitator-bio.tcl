# packages/dotlrn/www/facilitator-bio.tcl

ad_page_contract {
    
    displays the bio for a facilitator
    
    @author Deds Castillo (deds@i-manila.com.ph)
    @creation-date 2005-04-06
    @arch-tag: 0578045b-3a01-4072-a15b-e6af5a729079
    @cvs-id $Id$
} {
    {rel_type "dotlrn_admin_rel"}
    {community_id ""}
} -properties {
} -validate {
} -errors {
}

set title "Facilitator Bios"
set context [list $title]

if { $community_id eq "" } {
    set community_id [dotlrn_community::get_community_id]
}
# set rel_type "dotlrn_admin_rel"

db_multirow user_id_list get_user_id_list {
    select d.user_id
    from dotlrn_member_rels_approved d,
         persons p
    where d.community_id = :community_id
          and d.rel_type = :rel_type
          and d.user_id = p.person_id
    order by lower(p.last_name), lower(p.first_names)
}

set return_url [ad_return_url]
