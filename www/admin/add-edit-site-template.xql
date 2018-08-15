<?xml version="1.0"?>
<!DOCTYPE queryset PUBLIC "-//OpenACS//DTD XQL 1.0//EN" "http://www.thecodemill.biz/repository/xql.dtd">
<!--  -->
<!-- @author Victor Guerra (guerra@galileo.edu) -->
<!-- @creation-date 2005-05-20 -->
<!-- @cvs-id $Id$ -->

<queryset>
  <fullquery name="select_site_template_info">
    <querytext>
      select pretty_name, site_master, portal_theme_id
      from dotlrn_site_templates
      where site_template_id = :site_template_id
    </querytext>
  </fullquery>

  <fullquery name="insert_site_template">
    <querytext>
      insert into dotlrn_site_templates(site_template_id, pretty_name, site_master, portal_theme_id)
      values (:site_template_id,:pretty_name, :site_master, :portal_theme_id)
    </querytext>
  </fullquery>

  <fullquery name="update_site_template">
    <querytext>
      update dotlrn_site_templates set pretty_name = :pretty_name, 
      site_master=:site_master, portal_theme_id = :portal_theme_id 
      where site_template_id = :site_template_id
    </querytext>
  </fullquery>

  <fullquery name="select_portal_themes">
    <querytext>
      select name || '( ' || description || ' )', theme_id   
      from portal_element_themes
    </querytext>
  </fullquery>

</queryset>
