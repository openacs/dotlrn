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

    <fullquery name="select_term_info">
        <querytext>
            select term_name,
                   term_year,
                   to_char(start_date, 'Mon DD YYYY') as start_date,
                   to_char(end_date, 'Mon DD YYYY') as end_date
            from dotlrn_terms
            where term_id = :term_id
        </querytext>
    </fullquery>

    <fullquery name="select_classes">
        <querytext>
            select dotlrn_class_instances_full.*
            from dotlrn_class_instances_full
            where dotlrn_class_instances_full.term_id = :term_id
            order by dotlrn_class_instances_full.department_name,
                     dotlrn_class_instances_full.department_key,
                     dotlrn_class_instances_full.class_name,
                     dotlrn_class_instances_full.class_key,
                     dotlrn_class_instances_full.pretty_name,
                     dotlrn_class_instances_full.community_key
        </querytext>
    </fullquery>

    <fullquery name="select_classes_by_department">
        <querytext>
            select dotlrn_class_instances_full.*
            from dotlrn_class_instances_full
            where dotlrn_class_instances_full.term_id = :term_id
            and dotlrn_class_instances_full.department_key = :department_key
            order by dotlrn_class_instances_full.department_name,
                     dotlrn_class_instances_full.department_key,
                     dotlrn_class_instances_full.class_name,
                     dotlrn_class_instances_full.class_key,
                     dotlrn_class_instances_full.pretty_name,
                     dotlrn_class_instances_full.community_key
        </querytext>
    </fullquery>

    <fullquery name="select_all_classes">
        <querytext>
            select dotlrn_class_instances_full.*
            from dotlrn_class_instances_full
            order by dotlrn_class_instances_full.department_name,
                     dotlrn_class_instances_full.department_key,
                     dotlrn_class_instances_full.class_name,
                     dotlrn_class_instances_full.class_key,
                     dotlrn_class_instances_full.pretty_name,
                     dotlrn_class_instances_full.community_key
        </querytext>
    </fullquery>

    <fullquery name="select_all_classes_by_department">
        <querytext>
            select dotlrn_class_instances_full.*
            from dotlrn_class_instances_full
            where dotlrn_class_instances_full.department_key = :department_key
            order by dotlrn_class_instances_full.department_name,
                     dotlrn_class_instances_full.department_key,
                     dotlrn_class_instances_full.class_name,
                     dotlrn_class_instances_full.class_key,
                     dotlrn_class_instances_full.pretty_name,
                     dotlrn_class_instances_full.community_key
        </querytext>
    </fullquery>

</queryset>
