<?xml version="1.0"?>
<!DOCTYPE queryset PUBLIC "-//OpenACS//DTD XQL 1.0//EN" "http://www.thecodemill.biz/repository/xql.dtd">
<!-- packages/dotlrn/www/admin/club-new.xql -->
<!-- @author Roel Canicula (roelmc@aristoi.biz) -->
<!-- @creation-date 2004-06-26 -->
<!-- @arch-tag: bfc08c0a-40b6-462b-933a-f406c7e7b9ea -->
<!-- @cvs-id $Id$ -->

<queryset>

    <fullquery name="community_types">
    <querytext>
      select
        community_type,
        community_type
      from
        dotlrn_community_types
      order by
        community_type
    </querytext>
  </fullquery>

</queryset>
