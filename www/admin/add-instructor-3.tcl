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

# dotlrn/www/admin/add-instructor-3.tcl

ad_page_contract {
    @author yon (yon@openforce.net)
    @creation-date Jan 10, 2002
    @version $Id$
} -query {
    user_id:integer,notnull
    community_id:integer,notnull
    {referer ""}
}

set is_dotlrn_user [db_string is_dotlrn_user {}]

# if the user isn't already a dotLRN user make him so
if {!${is_dotlrn_user}} {
    dotlrn::user_add -user_id $user_id -type professor -can_browse
    dotlrn_privacy::set_user_is_non_guest -user_id $user_id -value t
}

# Add the relation
dotlrn_community::add_user -rel_type dotlrn_instructor_rel $community_id $user_id

ad_returnredirect $referer

