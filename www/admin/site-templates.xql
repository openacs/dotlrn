<?xml version="1.0"?>
<!DOCTYPE queryset PUBLIC "-//OpenACS//DTD XQL 1.0//EN" "http://www.thecodemill.biz/repository/xql.dtd">
<!--  -->
<!-- @author Victor Guerra (guerra@galileo.edu) -->
<!-- @creation-date 2005-05-19 -->
<!-- @cvs-id $Id$ -->

<queryset>
  <fullquery name="select_site_templates">
    <querytext>
      select dst.site_template_id, dst.pretty_name, 
      pet.name || ' ( ' || pet.description || ' )' as portal_theme
      from dotlrn_site_templates dst, portal_element_themes pet
      where dst.portal_theme_id = pet.theme_id 
    </querytext>
  </fullquery>
</queryset>
