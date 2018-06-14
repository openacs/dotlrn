<?xml version="1.0"?>
<!DOCTYPE queryset PUBLIC "-//OpenACS//DTD XQL 1.0//EN" "http://www.thecodemill.biz/repository/xql.dtd">
<!-- packages/dotlrn/www/admin/community-type.xql -->
<!-- @author Roel Canicula (roelmc@aristoi.biz) -->
<!-- @creation-date 2004-06-26 -->
<!-- @arch-tag: d8764f8e-748c-466d-8abf-07d58d03327d -->
<!-- @cvs-id $Id$ -->

<queryset>

  <fullquery name="community_type_exists">
    <querytext>
      select 1 from dotlrn_community_types
      where community_type = :community_type
    </querytext>
  </fullquery>

  <fullquery name="get_community_type">
    <querytext>
      select
        pretty_name,
        description
      from
        dotlrn_community_types
      where
        community_type = :community_type
    </querytext>
  </fullquery>

  <fullquery name="set_community_type">
    <querytext>
      update
        dotlrn_community_types
      set
        pretty_name = :pretty_name,
        description = :description
      where
        community_type = :community_type
    </querytext>
  </fullquery>

</queryset>
