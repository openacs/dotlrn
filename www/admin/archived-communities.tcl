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

set groups_pretty_plural "[parameter::get -parameter class_instances_pretty_plural] / [parameter::get -parameter clubs_pretty_plural]"

set title "Archived $groups_pretty_plural"
set context_bar [list $title]

db_multirow archived_comms select_archived_comms {} {
    set description [ad_quotehtml $description]
}

ad_return_template
