<?xml version="1.0"?>
<!DOCTYPE queryset PUBLIC "-//OpenACS//DTD XQL 1.0//EN" "http://www.thecodemill.biz/repository/xql.dtd">
<!-- packages/dotlrn/www/member-email-toggle.xql -->
<!-- @author Roel Canicula (roelmc@pldtdsl.net) -->
<!-- @creation-date 2005-07-22 -->
<!-- @arch-tag: 28de831d-8118-4fe4-91e1-5f31cde0456a -->
<!-- @cvs-id $Id$ -->

<queryset>
  <fullquery name="toggle_member_email">
    <querytext>
      update dotlrn_member_emails
      set enabled_p = case when enabled_p = 't' then 'f' else 't' end
      where community_id = :community_id
      and type = 'on join'
    </querytext>
  </fullquery>
</queryset>