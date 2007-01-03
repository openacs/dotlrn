ad_page_contract {
    Form to confirm a user dropping a single membership for themselves
} -query {
    {user_id:multiple,integer ""}
    {community_id ""}
    {referer "./"}
}

set page_title [_ dotlrn.Confirm_Drop]
set context [list $page_title]

set community_name [dotlrn_community::get_community_name [dotlrn_community::get_community_id]$community_id]
set confirm_message_label "[_ dotlrn.Are_you_sure_you_want_to_drop]"
ad_form -name deregister-self-confirm \
    -export {user_id community_id referer} \
    -has_submit 1 \
    -form {
	{confirm_message:text(inform) {label $confirm_message_label}}
	{drop_btn:text(submit) {label "[_ dotlrn.Drop_Membership]"}}
	{cancel_btn:text(submit) {label "[_ acs-kernel.common_Cancel]"}}
    } -on_submit {
	if {[info exists drop_btn] && $drop_btn ne ""} {
	    ad_returnredirect [export_vars -base deregister {user_id community_id referer}]
	} else {
	    ad_returnredirect $referer
	}
	ad_script_abort
    }

ad_return_template