<?xml version="1.0"?>

<queryset>

    <fullquery name="remove_file_from_community">
        <querytext>
            delete
            from dotlrn_research_papers
            where community_id = :community_id
            and file_id = :file_id
        </querytext>
    </fullquery>

</queryset>
