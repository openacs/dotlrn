<?xml version="1.0"?>

<queryset>
  <fullquery name="select_classes">
    <querytext>
      select class_key,
             pretty_name,
             description
      from dotlrn_classes_full
      order by pretty_name
    </querytext>
  </fullquery>
</queryset>
