<%

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

%>

<a href="<if @url@ nil>#dotlrn.register#</if><else>@url@</else><if @community_id@ not nil>?community_id=@community_id@</if><if @referer@ not nil>&referer=@referer@</if>"><if @label@ nil>#dotlrn.Join#</if><else>@label@</else></a>



