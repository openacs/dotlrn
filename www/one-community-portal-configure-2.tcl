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
    Form target for the Configuration page for an instance's portal template

    @author Arjun Sanyal (arjun@openforce.net)
    @version $Id$
} -query {
}

set form [ns_getform]
set portal_id [ns_set get $form portal_id]
set return_url [ns_set get $form return_url]
set anchor [ns_set get $form anchor]

portal::configure_dispatch -portal_id $portal_id -form $form

#ad_return_complaint 1 "one-community-portal-configure?portal_id=$portal_id&referer=$return_url#$anchor"
#ad_script_abort

ns_returnredirect "one-community-portal-configure?portal_id=$portal_id&referer=$return_url#$anchor"
