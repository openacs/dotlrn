<?xml version="1.0"?>
<!DOCTYPE queryset PUBLIC "-//OpenACS//DTD XQL 1.0//EN" "http://www.thecodemill.biz/repository/xql.dtd">
<!-- packages/dotlrn/www/admin/users-search-oracle.xql -->
<!-- @author Deds Castillo (deds@i-manila.com.ph) -->
<!-- @creation-date 2005-09-13 -->
<!-- @arch-tag: ce78dbd0-5112-40ed-bbc2-742ded1e66b3 -->
<!-- @cvs-id $Id$ -->

<queryset>
  
  <rdbms>
    <type>oracle</type>
    <version>8.1.6</version>
  </rdbms>
  
  <partialquery name="last_visit_g">
    <querytext>
    (dotlrn_users.user_id = users.user_id and users.last_visit <= (sysdate - :last_visit_greater))
    </querytext>
  </partialquery>
  
  <partialquery name="last_visit_l">
    <querytext>
    (dotlrn_users.user_id = users.user_id and users.last_visit >= (sysdate - :last_visit_less))
    </querytext>
  </partialquery>
  
</queryset>