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

# file-storage/www/folder-chunk.tcl

ad_page_contract {
    @author yon (yon@openforce.net)
    @creation-date Feb 22, 2002
    @version $Id$
} -query {
} -properties {
    folder_name:onevalue
    contents:multirow
}

if {![exists_and_not_null folder_id]} {
    ad_return_complaint 1 "bad folder id $folder_id"
    ad_script_abort
}

if {![exists_and_not_null viewing_user_id]} {
    set viewing_user_id [acs_magic_object "the_public"]
}

if {![exists_and_not_null n_past_days]} {
    set n_past_days 99999
}

set folder_name [fs::get_object_name -object_id $folder_id]

set rows [fs::get_folder_contents \
    -folder_id $folder_id \
    -user_id $viewing_user_id \
    -n_past_days $n_past_days \
]
template::util::list_of_ns_sets_to_multirow -rows $rows -var_name "contents"

ad_return_template
