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
    displays archived communities

    @author arjun (arjun@openforce.net)
    @version $Id$
} -query {
} -properties {
    title:onevalue
    context_bar:onevalue
    archived_comms:multirow
}

set groups_pretty_plural "[parameter::get -localize -parameter class_instances_pretty_plural] / [parameter::get -localize -parameter clubs_pretty_plural]"

set title "[_ dotlrn.archived_groups]"
set context_bar [list $title]

db_multirow -extend { unarchive_url } archived_comms select_archived_comms {} {
    set description [ad_quotehtml $description]
    set unarchive_url "unarchive?community_id=$community_id"
}


ad_return_template
