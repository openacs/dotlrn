
#
# Procs for DOTLRN filters
# Copyright 2001 OpenForce, inc.
# Distributed under the GNU GPL v2
#
# August 20th, 2001
#

ad_library {
    
    Procs for basic dotLRN filters
    
    @author ben@openforce.net
    @creation-date 2001-08-20
    
}

ad_proc -private dotlrn_filter {conn arg why} {
    A filter for dotLRN
} {
    ns_log Notice "dotLRN filter activated!!! Data as follows:
package_id: [ad_conn package_id]
url: [ad_conn url]
node_id: [ad_conn node_id]
package_key: [ad_conn package_key]
path_info: [ad_conn path_info]
"

return filter_ok
}
