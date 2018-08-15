<?xml version="1.0"?>
<!DOCTYPE queryset PUBLIC "-//OpenACS//DTD XQL 1.0//EN" "http://www.thecodemill.biz/repository/xql.dtd">
<!-- packages/dotlrn/www/member-email-toggle-postgresql.xql -->
<!-- @author Roel Canicula (roelmc@pldtdsl.net) -->
<!-- @creation-date 2005-08-20 -->
<!-- @cvs-id $Id$ -->

<queryset>
  
  <rdbms>
    <type>postgresql</type>
    <version>7.2</version>
  </rdbms>
  
  <fullquery name="toggle_member_email">
    <querytext>
      update dotlrn_member_emails
      set enabled_p = case when enabled_p then false else true end
      where community_id = :community_id
      and type = 'on join'
    </querytext>
  </fullquery>
  
</queryset>
