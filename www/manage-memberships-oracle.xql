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

    <fullquery name="select_n_member_classes">
        <querytext>
            select count(*)
            from dotlrn_class_instances_full,
                 dotlrn_member_rels_full
            where dotlrn_member_rels_full.user_id = :user_id
            and dotlrn_member_rels_full.community_id = dotlrn_class_instances_full.class_instance_id
        </querytext>
    </fullquery>

    <fullquery name="select_member_classes">
        <querytext>
            select dotlrn_class_instances_full.*,
                   dotlrn_member_rels_full.role,
                   dotlrn_member_rels_full.member_state,
                   acs_permission.permission_p(dotlrn_class_instances_full.class_instance_id, :user_id, 'admin') as admin_p
            from dotlrn_class_instances_full,
                 dotlrn_member_rels_full
            where dotlrn_member_rels_full.user_id = :user_id
            and dotlrn_member_rels_full.community_id = dotlrn_class_instances_full.class_instance_id
            order by dotlrn_class_instances_full.department_name,
                     dotlrn_class_instances_full.department_key,
                     dotlrn_class_instances_full.pretty_name,
                     dotlrn_class_instances_full.community_key
        </querytext>
    </fullquery>

    <fullquery name="select_member_classes_by_department">
        <querytext>
            select dotlrn_class_instances_full.*,
                   dotlrn_member_rels_full.role,
                   dotlrn_member_rels_full.member_state,
                   acs_permission.permission_p(dotlrn_class_instances_full.class_instance_id, :user_id, 'admin') as admin_p
            from dotlrn_class_instances_full,
                 dotlrn_member_rels_full
            where dotlrn_member_rels_full.user_id = :user_id
            and dotlrn_class_instances_full.department_key = :member_department_key
            and dotlrn_member_rels_full.community_id = dotlrn_class_instances_full.class_instance_id
            order by dotlrn_class_instances_full.department_name,
                     dotlrn_class_instances_full.department_key,
                     dotlrn_class_instances_full.pretty_name,
                     dotlrn_class_instances_full.community_key
        </querytext>
    </fullquery>

    <fullquery name="select_member_classes_by_term">
        <querytext>
            select dotlrn_class_instances_full.*,
                   dotlrn_member_rels_full.role,
                   dotlrn_member_rels_full.member_state,
                   acs_permission.permission_p(dotlrn_class_instances_full.class_instance_id, :user_id, 'admin') as admin_p
            from dotlrn_class_instances_full,
                 dotlrn_member_rels_full
            where dotlrn_member_rels_full.user_id = :user_id
            and dotlrn_class_instances_full.term_id = :member_term_id
            and dotlrn_member_rels_full.community_id = dotlrn_class_instances_full.class_instance_id
            order by dotlrn_class_instances_full.department_name,
                     dotlrn_class_instances_full.department_key,
                     dotlrn_class_instances_full.pretty_name,
                     dotlrn_class_instances_full.community_key
        </querytext>
    </fullquery>

    <fullquery name="select_member_classes_by_department_by_term">
        <querytext>
            select dotlrn_class_instances_full.*,
                   dotlrn_member_rels_full.role,
                   dotlrn_member_rels_full.member_state,
                   acs_permission.permission_p(dotlrn_class_instances_full.class_instance_id, :user_id, 'admin') as admin_p
            from dotlrn_class_instances_full,
                 dotlrn_member_rels_full
            where dotlrn_member_rels_full.user_id = :user_id
            and dotlrn_class_instances_full.department_key = :member_department_key
            and dotlrn_class_instances_full.term_id = :member_term_id
            and dotlrn_member_rels_full.community_id = dotlrn_class_instances_full.class_instance_id
            order by dotlrn_class_instances_full.department_name,
                     dotlrn_class_instances_full.department_key,
                     dotlrn_class_instances_full.pretty_name,
                     dotlrn_class_instances_full.community_key
        </querytext>
    </fullquery>

    <fullquery name="select_member_clubs">
        <querytext>
            select dotlrn_clubs_full.*,
                   dotlrn_member_rels_full.role,
                   dotlrn_member_rels_full.member_state,
                   acs_permission.permission_p(dotlrn_clubs_full.club_id, :user_id, 'admin') as admin_p
            from dotlrn_clubs_full,
                 dotlrn_member_rels_full
            where dotlrn_member_rels_full.user_id = :user_id
            and dotlrn_member_rels_full.community_id = dotlrn_clubs_full.club_id
            order by dotlrn_clubs_full.pretty_name,
                     dotlrn_clubs_full.community_key
        </querytext>
    </fullquery>

    <fullquery name="select_n_non_member_classes">
        <querytext>
            select count(*)
            from dotlrn_class_instances_full
            where dotlrn_class_instances_full.join_policy <> 'closed'
            and not exists (select 1
                            from dotlrn_member_rels_full
                            where dotlrn_member_rels_full.user_id = :user_id
                            and dotlrn_member_rels_full.community_id = dotlrn_class_instances_full.class_instance_id)
        </querytext>
    </fullquery>

    <fullquery name="select_non_member_classes">
        <querytext>
            select dotlrn_class_instances_full.*,
                   acs_permission.permission_p(dotlrn_class_instances_full.class_instance_id, :user_id, 'admin') as admin_p
            from dotlrn_class_instances_full
            where dotlrn_class_instances_full.join_policy <> 'closed'
            and not exists (select 1
                            from dotlrn_member_rels_full
                            where dotlrn_member_rels_full.user_id = :user_id
                            and dotlrn_member_rels_full.community_id = dotlrn_class_instances_full.class_instance_id)
            order by dotlrn_class_instances_full.department_name,
                     dotlrn_class_instances_full.department_key,
                     dotlrn_class_instances_full.pretty_name,
                     dotlrn_class_instances_full.community_key
        </querytext>
    </fullquery>

    <fullquery name="select_non_member_classes_by_department">
        <querytext>
            select dotlrn_class_instances_full.*,
                   acs_permission.permission_p(dotlrn_class_instances_full.class_instance_id, :user_id, 'admin') as admin_p
            from dotlrn_class_instances_full
            where dotlrn_class_instances_full.department_key = :non_member_department_key
            and dotlrn_class_instances_full.join_policy <> 'closed'
            and not exists (select 1
                            from dotlrn_member_rels_full
                            where dotlrn_member_rels_full.user_id = :user_id
                            and dotlrn_member_rels_full.community_id = dotlrn_class_instances_full.class_instance_id)
            order by dotlrn_class_instances_full.department_name,
                     dotlrn_class_instances_full.department_key,
                     dotlrn_class_instances_full.pretty_name,
                     dotlrn_class_instances_full.community_key
        </querytext>
    </fullquery>

    <fullquery name="select_non_member_classes_by_term">
        <querytext>
            select dotlrn_class_instances_full.*,
                   acs_permission.permission_p(dotlrn_class_instances_full.class_instance_id, :user_id, 'admin') as admin_p
            from dotlrn_class_instances_full
            where dotlrn_class_instances_full.term_id = :non_member_term_id
            and dotlrn_class_instances_full.join_policy <> 'closed'
            and not exists (select 1
                            from dotlrn_member_rels_full
                            where dotlrn_member_rels_full.user_id = :user_id
                            and dotlrn_member_rels_full.community_id = dotlrn_class_instances_full.class_instance_id)
            order by dotlrn_class_instances_full.department_name,
                     dotlrn_class_instances_full.department_key,
                     dotlrn_class_instances_full.pretty_name,
                     dotlrn_class_instances_full.community_key
        </querytext>
    </fullquery>

    <fullquery name="select_non_member_classes_by_department_by_term">
        <querytext>
            select dotlrn_class_instances_full.*,
                   acs_permission.permission_p(dotlrn_class_instances_full.class_instance_id, :user_id, 'admin') as admin_p
            from dotlrn_class_instances_full
            where dotlrn_class_instances_full.department_key = :non_member_department_key
            and dotlrn_class_instances_full.term_id = :non_member_term_id
            and dotlrn_class_instances_full.join_policy <> 'closed'
            and not exists (select 1
                            from dotlrn_member_rels_full
                            where dotlrn_member_rels_full.user_id = :user_id
                            and dotlrn_member_rels_full.community_id = dotlrn_class_instances_full.class_instance_id)
            order by dotlrn_class_instances_full.department_name,
                     dotlrn_class_instances_full.department_key,
                     dotlrn_class_instances_full.pretty_name,
                     dotlrn_class_instances_full.community_key
        </querytext>
    </fullquery>

    <fullquery name="select_non_member_clubs">
        <querytext>
            select dotlrn_clubs_full.*,
                   acs_permission.permission_p(dotlrn_clubs_full.club_id, :user_id, 'admin') as admin_p
            from dotlrn_clubs_full
            where dotlrn_clubs_full.join_policy <> 'closed'
            and not exists (select 1
                            from dotlrn_member_rels_full
                            where dotlrn_member_rels_full.user_id = :user_id
                            and dotlrn_member_rels_full.community_id = dotlrn_clubs_full.club_id)
            order by dotlrn_clubs_full.pretty_name,
                     dotlrn_clubs_full.community_key
        </querytext>
    </fullquery>

</queryset>
