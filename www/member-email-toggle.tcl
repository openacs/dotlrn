# packages/dotlrn/www/member-email-toggle.tcl

ad_page_contract {
    
    Toggle membership email
    
    @author Roel Canicula (roelmc@info.com.ph)
    @creation-date 2004-09-05
    @arch-tag: 75efba19-ee2c-4341-969e-26e88615b526
    @cvs-id $Id$
} {
    
} -properties {
} -validate {
} -errors {
}

set community_id [dotlrn_community::get_community_id]

db_dml toggle_member_email {
    update
      dotlrn_member_emails
    set
      enabled_p = case when enabled_p = 't' then 'f'::boolean else 't'::boolean end
    where
      community_id = :community_id and
      type = 'on join'
}

ad_returnredirect "one-community-admin"