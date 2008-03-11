<?xml version="1.0"?>

<queryset>

    <fullquery name="select_department_info">
        <querytext>
            select pretty_name,
                   description,
                   external_url
            from dotlrn_departments_full
            where department_key = :department_key
        </querytext>
    </fullquery>

    <fullquery name="update_department">
        <querytext>
            update dotlrn_departments
            set external_url = :external_url
            where department_key = :department_key
        </querytext>
    </fullquery>

    <fullquery name="update_community_type">
        <querytext>
            update dotlrn_community_types
            set pretty_name = :pretty_name,
                description = :description
            where community_type = :department_key
        </querytext>
    </fullquery>

    <fullquery name="update_package_name">
        <querytext>
            update apm_packages
                set instance_name = :pretty_name
                where package_id = ( select package_id
                        from dotlrn_departments_full
                        where department_key = :department_key)
        </querytext>
    </fullquery>

    <fullquery name="update_object_title">
        <querytext>
            update acs_objects
                set title = :pretty_name
                where object_id = ( select package_id
                        from dotlrn_departments_full
                        where department_key = :department_key)
        </querytext>
    </fullquery>

</queryset>
