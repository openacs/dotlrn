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

# /dotlrn/www/one-community-portal-template.tcl
ad_page_contract {
    Configuration page for an instance's portal template

    @author Arjun Sanyal (arjun@openforce.net)
    @version $Id$
} -query {
    {referer "one-community-admin"}
}

set portal_id [dotlrn_community::get_portal_template_id]

set rendered_page [portal::template_configure $portal_id $referer]

ad_return_template
