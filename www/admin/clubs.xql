<?xml version="1.0"?>

<queryset>

    <fullquery name="select_clubs">
        <querytext>
            select dotlrn_clubs_full.*
            from dotlrn_clubs_full
            order by dotlrn_clubs_full.pretty_name,
                     dotlrn_clubs_full.description
        </querytext>
    </fullquery>

</queryset>
