# packages/dotlrn/www/admin/community-types.tcl

ad_page_contract {
    
    List community types
    
    @author Roel Canicula (roelmc@aristoi.biz)
    @creation-date 2004-06-26
    @arch-tag: e635f9de-cfd5-4900-a38d-2ac21b8b06cf
    @cvs-id $Id$
} {
    
} -properties {
    title:onevalue
    context_bar:onevalue
    community_types:multirow
} -validate {
} -errors {
}

set title  "[_ dotlrn.Community_Types]"
set context_bar [list $title]

db_multirow -extend { 
    edit_url 
} community_types select_community_types { *SQL* } {
    set edit_url "community-type?[export_vars -url {community_type}]"
}

