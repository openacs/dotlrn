<?xml version="1.0"?>

<queryset>
  <fullquery name="dotlrn_applet::applet_exists_p.select_applet_exists_p">
    <querytext>
      select count(*)
      from dual
      where exists (select 1
                    from dotlrn_applets
                    where dotlrn_applets.applet_key = :applet_key)
    </querytext>
  </fullquery>
</queryset>
