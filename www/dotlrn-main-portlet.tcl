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

# dotlrn/www/dotlrn-main-portlet-procs.tcl

ad_page_contract {
    The display logic for the dotlrn main (Groups) portlet

    @author Arjun Sanyal (arjun@openforce.net)
    @version $Id$
} {
}

if {![exists_and_not_null show_buttons_p]} {
    set show_buttons_p 0
}

set user_id [ad_conn user_id]
set user_can_browse_p [dotlrn::user_can_browse_p -user_id $user_id]

set comm_type ""
db_multirow communities select_communities {} {
    set tree_level [expr $tree_level - $community_type_level]
    if {![string equal $simple_community_type dotlrn_community]} {
        set comm_type $simple_community_type
    } else {
        set simple_community_type $comm_type
    }
}

set dotlrn_url [dotlrn::get_url]

ad_return_template
