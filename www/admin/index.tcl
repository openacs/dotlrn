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
    Displays main dotLRN admin page

    @author Ben Adida (ben@openforce.net)
    @creation-date 2001-11-04
}

set oacs_site_wide_admin_p [acs_user::site_wide_admin_p]

set admin_pretty_name [parameter::get -localize -parameter dotlrn_admin_pretty_name]
set context_bar {}

# Some en_US messages reuse these configurable pretty names
set class_instances_pretty_plural [parameter::get -localize -parameter class_instances_pretty_plural]
set clubs_pretty_plural [parameter::get -localize -parameter clubs_pretty_plural]

set parameters_url [export_vars -base /shared/parameters { { package_id {[dotlrn::get_package_id]} } { return_url [ad_return_url] } }] 

set parameters_d_url [export_vars -base /shared/parameters { { package_id {[apm_package_id_from_key dotlrn-portlet]} } { return_url [ad_return_url] } }]

ad_return_template
