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

# dotlrn/www/community-types-chunk.tcl

ad_page_contract {
    @author yon (yon@openforce.net)
    @creation-date Dec 07, 2001
    @version $Id$
} -query {
} -properties {
    community_types:multirow
}

set community_type [dotlrn_community::get_community_type]

db_multirow community_types select_community_types {}

if { ! [parameter::get -parameter SelfRegistrationP -package_id [dotlrn::get_package_id] -default 1] && [template::multirow size community_types] == 0 } {
    set redirect_to [parameter::get -parameter SelfRegistrationRedirectTo -package_id [dotlrn::get_package_id] -default ""]

    if { $redirect_to ne "" } {
	ad_returnredirect $redirect_to
    } else {
	ad_returnredirect "not-allowed"
    }
    ad_script_abort
}

ad_return_template

