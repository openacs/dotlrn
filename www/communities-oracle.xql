<?xml version="1.0"?>

<queryset>
  <rdbms><type>oracle</type><version>8.1.6</version></rdbms>

  <fullquery name="select_all_communities_count">
    <querytext>
      select count(*)
      from dotlrn_communities_not_closed dotlrn_communities
    </querytext>
  </fullquery>

  <fullquery name="select_communities">
    <querytext>
      select dotlrn_communities.community_id,
             dotlrn_communities.community_type,
             dotlrn_communities.pretty_name,
             dotlrn_communities.description,
             dotlrn_communities.package_id,
             dotlrn_community.url(dotlrn_communities.community_id) as url,
             (select count(*)
              from dual
              where exists (select 1
                            from dotlrn_member_rels_full
                            where dotlrn_member_rels_full.user_id = :user_id
                            and dotlrn_member_rels_full.community_id = dotlrn_communities.community_id)) as member_p,
             decode(acs_permission.permission_p(:user_id, dotlrn_communities.community_id, 'admin'),'f',0,1) as admin_p
      from dotlrn_communities_not_closed dotlrn_communities
      order by dotlrn_communities.community_type, dotlrn_communities.pretty_name
    </querytext>
  </fullquery>

  <fullquery name="select_active_communities">
    <querytext>
      select dotlrn_communities.community_id,
             dotlrn_communities.community_type,
             dotlrn_communities.pretty_name,
             dotlrn_communities.description,
             dotlrn_communities.package_id,
             dotlrn_community.url(dotlrn_communities.community_id) as url,
             (select count(*)
              from dual
              where exists (select 1
                            from dotlrn_member_rels_full
                            where dotlrn_member_rels_full.user_id = :user_id
                            and dotlrn_member_rels_full.community_id = dotlrn_communities.community_id)) as member_p,
             decode(acs_permission.permission_p(:user_id, dotlrn_communities.community_id, 'admin'),'f',0,1) as admin_p
      from dotlrn_active_comms_not_closed dotlrn_communities
      order by dotlrn_communities.community_type, dotlrn_communities.pretty_name
    </querytext>
  </fullquery>

  <fullquery name="select_all_communities_count_by_type">
    <querytext>
      select count(*)
      from dotlrn_communities_not_closed dotlrn_communities
      where dotlrn_communities.community_type = :community_type
    </querytext>
  </fullquery>

  <fullquery name="select_communities_by_type">
    <querytext>
      select dotlrn_communities.community_id,
             dotlrn_communities.community_type,
             dotlrn_communities.pretty_name,
             dotlrn_communities.description,
             dotlrn_communities.package_id,
             dotlrn_community.url(dotlrn_communities.community_id) as url,
             (select count(*)
              from dual
              where exists (select 1
                            from dotlrn_member_rels_full
                            where dotlrn_member_rels_full.user_id = :user_id
                            and dotlrn_member_rels_full.community_id = dotlrn_communities.community_id)) as member_p,
             decode(acs_permission.permission_p(:user_id, dotlrn_communities.community_id, 'admin'),'f',0,1) as admin_p
      from dotlrn_communities_not_closed dotlrn_communities
      where dotlrn_communities.community_type = :community_type
      order by dotlrn_communities.pretty_name
    </querytext>
  </fullquery>

  <fullquery name="select_active_communities_by_type">
    <querytext>
      select dotlrn_communities.community_id,
             dotlrn_communities.community_type,
             dotlrn_communities.pretty_name,
             dotlrn_communities.description,
             dotlrn_communities.package_id,
             dotlrn_community.url(dotlrn_communities.community_id) as url,
             (select count(*)
              from dual
              where exists (select 1
                            from dotlrn_member_rels_full
                            where dotlrn_member_rels_full.user_id = :user_id
                            and dotlrn_member_rels_full.community_id = dotlrn_communities.community_id)) as member_p,
             decode(acs_permission.permission_p(:user_id, dotlrn_communities.community_id, 'admin'),'f',0,1) as admin_p
      from dotlrn_active_comms_not_closed dotlrn_communities
      where dotlrn_communities.community_type = :community_type
      order by dotlrn_communities.pretty_name
    </querytext>
  </fullquery>
</queryset>
