<?xml version="1.0"?>

<queryset>

    <fullquery name="add_file_to_community">
        <querytext>
            insert
            into dotlrn_research_papers
            (community_id, file_id)
            values
            (:community_id, :file_id)
        </querytext>
    </fullquery>

</queryset>
