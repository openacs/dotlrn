ad_page_contract {
} -query {
    {community_id ""}
    {referer "control-panel"}
}

set spam_name [bulk_mail::parameter -parameter PrettyName -default Spam]
set context_bar [list [list $referer [_ dotlrn.Admin]] "$spam_name [_ dotlrn.Community]"]

if { ![exists_and_not_null community_id] } {
  set community_id [dotlrn_community::get_community_id]
}
set community_name [dotlrn_community::get_community_name $community_id]

# use my_user_id here so we don't confuse with user_id from the query
set my_user_id [ad_conn user_id]

dotlrn::require_user_read_private_data -user_id $my_user_id -object_id $community_id

set site_wide_admin_p [permission::permission_p \
    -object_id [acs_magic_object security_context_root] \
    -privilege admin \
]
if {!$site_wide_admin_p} {
    set admin_p [dotlrn::user_can_admin_community_p -user_id $my_user_id -community_id $community_id]
    set read_private_data_p [dotlrn::user_can_read_private_data_p -user_id $my_user_id]
} else {
    set admin_p 1
    set read_private_data_p 1
}

set community_id [dotlrn_community::get_community_id]
db_multirow current_members select_current_members {}

set exported_vars [export_vars -form { referer }]

ad_return_template