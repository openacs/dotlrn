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

# /dotlrn/www/admin/one-instance-portal-template-2.tcl
ad_page_contract {
    Form target for the Configuration page for an instance's portal template

    @author Arjun Sanyal (arjun@openforce.net)
    @version $Id$
} -query {
}

set form [ns_getform]
set portal_id [ns_set get $form portal_id]
set return_url [ns_set get $form return_url]

portal::template_configure_dispatch -portal_id $portal_id -form $form

ns_returnredirect "one-community-portal-template?portal_id=$portal_id&return_url=$return_url"
