<?xml version="1.0"?>
<!DOCTYPE queryset PUBLIC "-//OpenACS//DTD XQL 1.0//EN" "http://www.thecodemill.biz/repository/xql.dtd">
<!-- packages/dotlrn/www/admin/users-search.xql -->
<!-- @author Deds Castillo (deds@i-manila.com.ph) -->
<!-- @creation-date 2005-09-13 -->
<!-- @arch-tag: dff66e7e-e3d9-49f0-81e4-5979549a840c -->
<!-- @cvs-id $Id$ -->
<queryset>

  <partialquery name="last_visit_g">
    <querytext>
      (dotlrn_users.user_id = users.user_id and users.last_visit <= current_timestamp - interval :last_visit_greater day)
    </querytext>
  </partialquery>

  <partialquery name="last_visit_l">
    <querytext>
      (dotlrn_users.user_id = users.user_id and users.last_visit >= current_timestamp - interval :last_visit_less day)
    </querytext>
  </partialquery>

</queryset>
