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
    <fullquery name="select_classes">
        <querytext>
            select dotlrn_classes_full.class_key,
                   dotlrn_classes_full.pretty_name,
                   dotlrn_classes_full.description,
                   dotlrn_classes_full.department_key,
                   dotlrn_departments_full.pretty_name as department_name
            from dotlrn_classes_full,
                 dotlrn_departments_full
            where dotlrn_classes_full.department_key = dotlrn_departments_full.department_key
            order by dotlrn_departments_full.pretty_name,
                     dotlrn_classes_full.class_key,
                     dotlrn_classes_full.pretty_name
        </querytext>
    </fullquery>

    <fullquery name="select_classes_by_department">
        <querytext>
            select dotlrn_classes_full.class_key,
                   dotlrn_classes_full.pretty_name,
                   dotlrn_classes_full.description,
                   dotlrn_classes_full.department_key,
                   dotlrn_departments_full.pretty_name as department_name
            from dotlrn_classes_full,
                 dotlrn_departments_full
            where dotlrn_classes_full.department_key = :department_key
            and dotlrn_classes_full.department_key = dotlrn_departments_full.department_key
            order by dotlrn_classes_full.class_key,
                     dotlrn_classes_full.pretty_name
        </querytext>
    </fullquery>
</queryset>
