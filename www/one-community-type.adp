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

<master>
<property name="context_bar">@context_bar@</property>
<property name="title">@title@</property>

<p></p>

<blockquote>
  @description@
</blockquote>

<p></p>

<blockquote>
  <include src="community-types-chunk" title="@community_type_title@">
</blockquote>

<p></p>

<blockquote>
  <include src="communities-chunk" title="@communities_title@" community_type="@community_type@">
</blockquote>


