# packages/dotlrn/www/member-email.tcl

ad_page_contract {
    
    Email to send users when they join this community
    
    @author Roel Canicula (roel@solutiongrove.com)
    @creation-date 2004-09-05
    @arch-tag: 64bff694-7a52-40ae-94f6-17d853356ccb
    @cvs-id $Id$
} {

} -properties {
} -validate {
} -errors {
}

set community_id [dotlrn_community::get_community_id]
dotlrn::require_user_admin_community -community_id $community_id

db_0or1row member_email {
    select
      email_id
    from
      dotlrn_member_emails
    where 
      community_id = :community_id and 
      type = 'on join'
}

ad_form -name "member_email" -form {
    {email_id:key}
    {from_addr:text {label "From Address"} {html {size 40}}}
    {subject:text {label "Subject"} {html {size 40}}}
    {email:richtext,optional {label "Message"} {html {rows 30 cols 80 wrap soft}} {htmlarea_p 1}}
} -on_request {

    set from_addr [cc_email_from_party [ad_conn user_id]]
    set subject "Welcome to [dotlrn_community::get_community_name $community_id]!"

} -on_submit {

    set email [template::util::richtext::get_property contents $email]

} -new_data {
    
    db_dml new_email {
	insert into
	  dotlrn_member_emails
	  (community_id, type, from_addr, subject, email)
	values
	  (:community_id, 'on join', :from_addr, :subject, :email)
    }

} -edit_request {

    db_1row member_email {
	select
	  from_addr,
	  subject,
	  email
	from
	  dotlrn_member_emails
	where 
	  email_id = :email_id
    }

    set email [list $email ""]

} -edit_data {

    db_dml new_email {
	update
	  dotlrn_member_emails
	set
	  from_addr = :from_addr,
	  subject = :subject,
	  email = :email
	where
	  email_id = :email_id
    }

} -after_submit {
    
    ad_returnredirect "one-community-admin"
    ad_script_abort

}