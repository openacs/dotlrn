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
    
    Subscribe group members to a forum and set autosubscription mode
    
    @author Don Baccus (dhogaza@pacifier.com)
    @cvs_id $Id$
} {
    forum_id:integer,notnull
    community_id:integer,notnull
    return_url:notnull
}

db_transaction {
    db_dml update_autosubscribe_p {}
    notification::request::delete_all -object_id $forum_id
}

ad_returnredirect $return_url
