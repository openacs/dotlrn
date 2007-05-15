# packages/dotlrn/www/register-link.tcl

ad_page_contract {
    
    Build link to register in a dotlrn community
    
    @author Emmanuelle Raffenne (eraffenne@dia.uned.es)
    @creation-date 2007-03-29
    @arch-tag: a781edfd-415d-47e2-a7fe-fbb2f7ac4241
    @cvs-id $Id$
} {
} -properties {
} -validate {
} -errors {
}

if { ![exists_and_not_null url] } {
    set base_url "register"
} else {
    set base_url $url
}

if { [exists_and_not_null referer] } {
    set url "[export_vars -base $base_url {community_id}]&referer=$referer"
} else {
    set url [export_vars -base $base_url {community_id}]
}
    
if { ![exists_and_not_null label] } {
    set label [_ dotlrn.Join]
}
