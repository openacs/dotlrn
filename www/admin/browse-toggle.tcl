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

# dotlrn/www/admin/browse-toggle.tcl

ad_page_contract {
    @author Caroline Meeks (caroline@meekshome.com)
    @creation-date November 19, 2002
    @version $Id$
} -query {
    user_id
    can_browse_p
    {referer "users"}
}


#update can_browse_p
dotlrn::set_can_browse -user_id $user_id -can_browse\=$can_browse_p

util_memoize_flush_regexp  $user_id
ad_returnredirect $referer


