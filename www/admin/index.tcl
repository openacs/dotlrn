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

set admin_pretty_name [parameter::get -localize -parameter dotlrn_admin_pretty_name]
set context_bar {}

# Some en_US messages reuse these configurable pretty names
set class_instances_pretty_plural [parameter::get -localize -parameter class_instances_pretty_plural]
set clubs_pretty_plural [parameter::get -localize -parameter clubs_pretty_plural]

ad_return_template
