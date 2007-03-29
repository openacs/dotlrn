<?xml version="1.0"?>

<queryset>

  <fullquery name="dotlrn::apm::after_upgrade.get_default_values">
    <querytext>
      select default_value
      from apm_parameters
      where package_key = 'dotlrn'
        and parameter_name like '%_csv'
    </querytext>
  </fullquery>

  <fullquery name="dotlrn::apm::after_upgrade.set_accesskeys">
    <querytext>
      update portal_pages
      set accesskey = :accesskey
      where pretty_name = :title
    </querytext>
  </fullquery>

</queryset>
