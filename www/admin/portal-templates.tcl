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
    Displays dotLRN portal templates admin page

    @author arjun (arjun@openforce.net)
    @version $Id$
} -query {
} -properties {
    title:onevalue
    context_bar:onevalue
    departments:multirow
}

set title [_ dotlrn.Templates]
set context_bar $title
set url "[portal::mount_point]admin"
set referer [ad_conn url]

db_multirow templates select_portal_templates {} {
    set name [lang::util::localize $name]
}

