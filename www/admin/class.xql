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

  <fullquery name="select_class_info">
    <querytext>
      select pretty_name,
             description,
             supertype
      from dotlrn_classes_full
      where class_key = :class_key
    </querytext>
  </fullquery>

  <fullquery name="select_all_class_instances">
    <querytext>
      select *
      from dotlrn_class_instances_full dotlrn_class_instances
      where dotlrn_class_instances.class_key = :class_key
    </querytext>
  </fullquery>

  <fullquery name="select_class_instances">
    <querytext>
      select *
      from dotlrn_class_instances_full dotlrn_class_instances
      where dotlrn_class_instances.class_key = :class_key
      and dotlrn_class_instances.term_id = :term_id
    </querytext>
  </fullquery>

</queryset>
