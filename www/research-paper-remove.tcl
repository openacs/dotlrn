#
#  Copyright (C) 2001, 2002 OpenForce, Inc.
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

# dotlrn/www/research-paper-remove.tcl

ad_page_contract {
    @author yon (yon@milliped.com)
    @creation-date Mar 04, 2002
    @version $Id$
} -query {
    file_id:integer,notnull
    {referer "one-community-admin"}
} -properties {
}

set community_id [dotlrn_community::get_community_id]
dotlrn::require_user_admin_community $community_id

db_dml remove_file_from_community {}

ad_returnredirect $referer
