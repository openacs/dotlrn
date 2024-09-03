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
    Web log controls for user control panel

    @author Caroline Meeks (cmeeks@mit.edu)
    @creation-date 2002-09-13
    @cvs-id $Id$
}

set user_id [auth::require_login]


set weblog_package_id [lindex [site_node::get_children \
                                   -package_key forums \
                                   -element object_id \
                                   -node_id [ad_conn node_id]] 0]

set weblog_url [site_node::get_url_from_object_id -object_id $weblog_package_id]/forum-view

db_multirow weblogs weblogs {select name, forum_id, to_char(o.last_modified, 'Mon DD, YYYY') as latest_post from forums_forums_enabled f, acs_objects o where o.object_id = forum_id and o.creation_user = :user_id and f.package_id = :weblog_package_id}


ad_return_template

# Local variables:
#    mode: tcl
#    tcl-indent-level: 4
#    indent-tabs-mode: nil
# End:
