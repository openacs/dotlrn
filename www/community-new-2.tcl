

ad_page_contract {
    Create a New Community - process form

    @author Ben Adida (ben@openforce.net)
    @creation-date 2001-10-05
} {
    pretty_name:trim
    description
    {year ""}
    {term ""}
}

# Get the community type
set community_type [dotlrn_community::get_community_type]

# assume it's a class for now
set community_id [dotlrn_class::new_instance -description "" $community_type $pretty_name $term $year]
