<?xml version="1.0"?>

<queryset>
    <rdbms><type>oracle</type><version>8.1.6</version></rdbms>

    <fullquery name="select_archived_comms">
        <querytext>
            select pretty_name, 
                   description,
                   dotlrn_community.url(community_id) as url
            from dotlrn_communities_all
            where archived_p = 't'
            order by pretty_name,
                     description
        </querytext>
    </fullquery>

</queryset>
