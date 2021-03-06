ad_page_contract {
    
    Build link to register in a dotlrn community
    
    @author Emmanuelle Raffenne (eraffenne@dia.uned.es)
    @creation-date 2007-03-29
    @cvs-id $Id$
} {
} -properties {
} -validate {
} -errors {
}

if { ![info exists url] || $url eq "" } {
    set base_url "register"
} else {
    set base_url $url
}

if { [info exists referer] && $referer ne "" } {
    set url [export_vars -base $base_url {community_id referer}]
} else {
    set url [export_vars -base $base_url {community_id}]
}
    
if { ![info exists label] || $label eq "" } {
    set label [_ dotlrn.Join]
}

# Local variables:
#    mode: tcl
#    tcl-indent-level: 4
#    indent-tabs-mode: nil
# End:
