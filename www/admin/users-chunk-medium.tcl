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
    @author yon (yon@openforce.net)
    @creation-date 2002-01-30
    @version $Id$
} -query {
    {section A}
} -properties {
    user_id:onevalue
    control_bar:onevalue
    users:multirow
}

set user_id [ad_conn user_id]
set dotlrn_package_id [dotlrn::get_package_id]
set root_object_id [acs_magic_object security_context_root]

if {![exists_and_not_null type]} {
    set type admin
}

if {![exists_and_not_null referer]} {
    set referer "[dotlrn::get_admin_url]/users"
}

set dimension_list {A B C D E F G H I J K L M N O P Q R S T U V W X Y Z}
foreach dimension $dimension_list {
    lappend dimensions [list $dimension $dimension {}]
}
lappend dimensions [list Other Other {}]

set control_bar [portal::dimensional -no_bars [list [list section {} $section $dimensions]]]

set i 1
if {[string equal $type deactivated] == 1} {
    set query select_deactivated_users
    if {[string match Other $section]} {
        append query "_other"
    }
    db_multirow users $query {} {
        set users:${i}(access_level) Limited
        incr i
    }
} elseif {[string equal $type pending] == 1} {
    set query select_non_dotlrn_users
    if {[string match Other $section]} {
        append query "_other"
    }
    db_multirow users $query {} {
        set users:${i}(access_level) N/A
        incr i
    }
} else {
    set query select_dotlrn_users
    if {[string match Other $section]} {
        append query "_other"
    }
    db_multirow users $query {} {
        if {[dotlrn::user_can_browse_p -user_id $user_id]} {
            set users:${i}(access_level) Full
        } else {
            set users:${i}(access_level) Limited
        }
        incr i
    }
}

ad_return_template

