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
    create a new club - input form

    @author yon (yon@openforce.net)
    @creation-date 2001-12-03
    @version $Id$
} -query {
    {referer "clubs"}
} -properties {
    title:onevalue
    context_bar:onevalue
}

form create add_club

element create add_club pretty_name \
    -label "Name" \
    -datatype text \
    -widget text \
    -html {size 60}

element create add_club description \
    -label "Description" \
    -datatype text \
    -widget textarea \
    -html {rows 5 cols 60 wrap soft} \
    -optional

element create add_club join_policy \
    -label "Join Policy" \
    -datatype text \
    -widget select \
    -options {{Open open} {"Needs Approval" "needs approval"} {Closed closed}}

element create add_club referer \
    -label "Referer" \
    -datatype text \
    -widget hidden \
    -value $referer

if {[form is_valid add_club]} {
    form get_values add_club \
         pretty_name description join_policy referer

    set key [dotlrn_club::new \
        -description $description \
        -pretty_name $pretty_name \
        -join_policy $join_policy]

    ad_returnredirect $referer
    ad_script_abort
}

set title "New [dotlrn::parameter clubs_pretty_name]"
set context_bar [list [list clubs [dotlrn::parameter clubs_pretty_plural]] [list New [dotlrn::parameter clubs_pretty_name]]]

ad_return_template
