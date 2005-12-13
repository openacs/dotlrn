set user_id [ad_get_user_id]
set community_id [dotlrn_community::get_community_id]
set dotlrn_package_id [dotlrn::get_package_id]

if {![empty_string_p $community_id]} {
    set dotlrn_master [dotlrn_community::get_dotlrn_master -community_id $community_id]
} elseif {$user_id } {
    ns_log Warning "vguerra voy a buscar el template de $user_id"
    set dotlrn_master [dotlrn::get_dotlrn_master -user_id $user_id]
} else {    
    set dotlrn_master  [parameter::get -package_id $dotlrn_package_id -parameter "DefaultMaster_p" \
			    -default "/packages/dotlrn/www/dotlrn-master"]
}
