<?xml version="1.0"?>
<!DOCTYPE queryset PUBLIC "-//OpenACS//DTD XQL 1.0//EN" "http://www.thecodemill.biz/repository/xql.dtd">
<!-- packages/dotlrn/www/admin/community-types.xql -->
<!-- @author Roel Canicula (roelmc@aristoi.biz) -->
<!-- @creation-date 2004-06-26 -->
<!-- @cvs-id $Id$ -->

<queryset>
  
  <fullquery name="select_community_types">
    <querytext>
      select
        community_type,
        supertype,
        pretty_name,
        description
      from
        dotlrn_community_types
      order by
        community_type
    </querytext>
  </fullquery>

</queryset>
