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
    A simple target for the portal configuration

    @author Arjun Sanyal (arjun@openforce.net)
    @author Ben Adida (ben@openforce.net)
    @creation-date 2001-10-24
} {
    portal_id:naturalnum,object_id,notnull
    element_id:naturalnum,object_id,optional
    page_id:naturalnum,object_id,optional
    theme_id:naturalnum,object_id,optional
    layout_id:naturalnum,object_id,optional
    region:string_length(max|20),optional
    direction:word,optional
    pretty_name:string_length(max|200),optional
    {anchor ""}
}

# Check if this is a community type level thing
if {[parameter::get -parameter community_type_level_p] == 1} {
    ad_returnredirect "one-community-type"
    ad_script_abort
}

portal::configure_dispatch -portal_id $portal_id -form [ns_getform]

ad_returnredirect [export_vars -base "configure" -anchor $anchor]
ad_script_abort

# Local variables:
#    mode: tcl
#    tcl-indent-level: 4
#    indent-tabs-mode: nil
# End:
