<?xml version="1.0"?>
<!--

  Copyright (C) 2001, 2002 OpenForce, Inc.

  This file is part of dotLRN.

  dotLRN is free software; you can redistribute it and/or modify it under the
  terms of the GNU General Public License as published by the Free Software
  Foundation; either version 2 of the License, or (at your option) any later
  version.

  dotLRN is distributed in the hope that it will be useful, but WITHOUT ANY
  WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
  FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more
  details.

-->


<queryset>
<rdbms><type>oracle</type><version>8.1.6</version></rdbms>

<fullquery name="select_classes">
<querytext>
select class_key, pretty_name, package_id from dotlrn_classes, dotlrn_community_types where dotlrn_community_types.community_type=dotlrn_classes.class_key order by class_key
</querytext>
</fullquery>

</queryset>
