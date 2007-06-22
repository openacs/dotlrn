#
#  Copyright (C) 2001, 2002 MIT
#
#  This file is part of dotLRN.
#
#  dotLRN is free software; you can redistribute it and/or modify it under the
#  terms of the GNU General Public License as published by the Free Software
#  Foundation; either version 2 of the License, or (at your option) any later
#  version.
#
#  dotLRN is distributed in the hope that it will be useful, but WITHOUT ANY
#  WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
#  FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more
#  details.
#

ad_page_contract {

    My account page for a user.

    @author Ben Adida (ben@openforce.net)
    @author yon (yon@openforce.net)
    @creation-date 2001-11-10
    @version $Id$

} -query {
} -properties {
    title:onevalue
    admin_p:onevalue
    admin_url:onevalue
    referer:onevalue
}


set dotlrn_url [dotlrn::get_url]
set dotlrn_package_id [dotlrn::get_package_id]
set portal_id [dotlrn::get_portal_id -user_id [ad_get_user_id]]

# Make sure user is logged in
set user_id [auth::require_login -account_status closed]

set title [parameter::get -localize -parameter admin_page_name]
set admin_p [dotlrn::admin_p]
set admin_url "[dotlrn::get_url]/admin"
set cockpit_url "[dotlrn::get_url]/admin/cockpit"
set referer [ns_conn url]
set admin_pretty_name [parameter::get -localize -parameter dotlrn_admin_pretty_name]
set system_owner [ad_system_owner]

set pvt_home [ad_pvt_home]
set pvt_home_name [ad_pvt_home_name]

acs_user::get -array user -include_bio -user_id $user_id

set account_status [ad_conn account_status]

set community_member_url [acs_community_member_url -user_id $user_id]

set notifications_url [lindex [site_node::get_children -node_id [subsite::get_element -element node_id] -package_key "notifications"] 0]

set system_name [ad_system_name]

if { [llength [lang::system::get_locales]] > 1 } { 
    set change_locale_url [apm_package_url_from_key "acs-lang"]
}

set whos_online_url "[subsite::get_element -element url]shared/whos-online"
set make_visible_url "[subsite::get_element -element url]shared/make-visible"
set make_invisible_url "[subsite::get_element -element url]shared/make-invisible"
set invisible_p [whos_online::user_invisible_p [ad_conn untrusted_user_id]]

if { ![db_0or1row get_portrait_info {}] } {
    set portrait_state "upload"
} else {
    if { $portrait_title eq "" } {
        set portrait_title "[_ acs-subsite.no_portrait_title_message]"
	set portrait_state "show"
	set portrait_publish_date [lc_time_fmt $publish_date "%q"]
    }
}
set portrait_upload_url [export_vars -base "../user/portrait/upload" { { return_url [ad_return_url] } }]
set subsite_url [ad_conn vhost_subsite_url]
set pvt_home_url [ad_pvt_home]

set allowed_to_change_site_template_p [parameter::get -package_id $dotlrn_package_id -parameter "UserChangeSiteTemplate_p" \
			      -default 0]

set user_info_template [parameter::get -package_id [ad_conn subsite_id] -parameter UserInfoTemplate -default "/packages/acs-subsite/lib/user-info"]