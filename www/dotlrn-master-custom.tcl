set user_id [ad_get_user_id]
set community_id [dotlrn_community::get_community_id]
set dotlrn_package_id [dotlrn::get_package_id]

if {![empty_string_p $community_id]} {
    set dotlrn_master [dotlrn_community::get_dotlrn_master -community_id $community_id]
} elseif {$user_id } {
    #unima-nm
    #set dotlrn_master [dotlrn::get_dotlrn_master -user_id $user_id]
    set dotlrn_master "/packages/dotlrn/www/dotlrn-master"
} else {    
    set dotlrn_master  [parameter::get -package_id $dotlrn_package_id -parameter "DefaultMaster_p" \
			    -default "/packages/dotlrn/www/dotlrn-master"]
}

if {![exists_and_not_null title]} {
    set title [ad_system_name]
}