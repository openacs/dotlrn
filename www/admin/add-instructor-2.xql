<?xml version="1.0"?>

<queryset>

    <fullquery name="select_users">
        <querytext>
            select user_id,
                   first_names,
                   last_name,
                   email
            from   registered_users
            where  lower(first_names || ' ' || last_name || ' ' || email) like '%' || lower(:search_text) || '%'
        </querytext>
    </fullquery>

</queryset>
