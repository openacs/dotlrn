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
  <fullquery name="select_terms">
    <querytext>
      select dotlrn_terms.term_id,
             dotlrn_terms.term_name,
             dotlrn_terms.term_year,
             to_char(dotlrn_terms.start_date, 'Mon DD YYYY') as start_date,
             to_char(dotlrn_terms.end_date, 'Mon DD YYYY') as end_date,
             (select count(*)
              from dotlrn_class_instances
              where dotlrn_class_instances.term_id = dotlrn_terms.term_id) as n_classes
      from dotlrn_terms
      order by dotlrn_terms.start_date
    </querytext>
  </fullquery>
</queryset>
