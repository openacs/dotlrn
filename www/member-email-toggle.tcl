ad_page_contract {
    
    Toggle membership email
    
    @author Roel Canicula (roelmc@info.com.ph)
    @creation-date 2004-09-05
    @cvs-id $Id$
} {
    
} -properties {
} -validate {
} -errors {
}

set community_id [dotlrn_community::get_community_id]

db_dml toggle_member_email {}

ad_returnredirect "one-community-admin"
ad_script_abort

# Local variables:
#    mode: tcl
#    tcl-indent-level: 4
#    indent-tabs-mode: nil
# End:
