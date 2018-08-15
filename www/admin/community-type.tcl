ad_page_contract {
    
    Add / Edit a community type
    
    @author Roel Canicula (roelmc@aristoi.biz)
    @creation-date 2004-06-26
    @cvs-id $Id$
} {
    {community_type:notnull,optional}
} -properties {
    title:onevalue
    context_bar:onevalue
} -validate {
} -errors {
}

set edit_p [expr {[info exists community_type] &&
                  [db_0or1row community_type_exists {}]}]

if { $edit_p } {
    set title "[_ dotlrn.edit_community_type]"

    ad_form -name "new_community_type" -form {
	{original_community_type:text(hidden) {value $community_type}}
	{community_type:text(hidden) {value $community_type}}
	{_community_type:text(inform) {label "[_ dotlrn.Community_Type]"} {value $community_type}}
    }
} else {
    set title "[_ dotlrn.new_community_type]"

    ad_form -name "new_community_type" -form {
	{community_type:text {label "[_ dotlrn.Community_Type]"} {html {size 60 maxlength 100}}}
    }
}
set context_bar [list [list community-types "[_ dotlrn.Community_Types]"] $title]

ad_form -extend -name "new_community_type" -form {
    {pretty_name:text {label "[_ dotlrn.Pretty_Name]"} {html {size 60 maxlength 100}}}
    {description:text(textarea),optional {label "[_ dotlrn.Description]"} {html {rows 5 cols 60}}}
} -validate {
    {community_type
	{ ![db_0or1row community_type_exists {}] || 
	    [info exists original_community_type] }
	"[_ community_type_exists]"
    }
} -on_request {
    if { $edit_p } {
        db_1row get_community_type {}
    }
} -on_submit {
    if { ![info exists original_community_type] } {
	# New type, create it
	dotlrn_community::new_type -description $description \
	    -community_type_key $community_type \
	    -pretty_name $pretty_name
    } else {
	# Update type
	db_dml set_community_type {}
    }
} -after_submit {
    ad_returnredirect "community-types"
    ad_script_abort
}

# Local variables:
#    mode: tcl
#    tcl-indent-level: 4
#    indent-tabs-mode: nil
# End:
