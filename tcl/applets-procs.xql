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

    <fullquery name="dotlrn_applet::get_applet_id_from_key.select">
        <querytext>
            select applet_id
            from dotlrn_applets
            where applet_key = :applet_key
        </querytext>
    </fullquery>

    <fullquery name="dotlrn_applet::add_applet_to_dotlrn.insert">
        <querytext>
            insert
            into dotlrn_applets
            (applet_id, applet_key, package_key, status)
            values
            (acs_object_id_seq.nextval, :applet_key, :package_key, :active_p)
        </querytext>
    </fullquery>

    <fullquery name="dotlrn_applet::list_applets_not_cached.select_dotlrn_applets">
        <querytext>
            select applet_key
            from dotlrn_applets
        </querytext>
    </fullquery>

</queryset>
