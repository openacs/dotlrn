# 

ad_page_contract {
    
    Parameter Administration for Site Templates
    
    @author Victor Guerra (guerra@galileo.edu)
    @creation-date 2005-12-08
    @arch-tag: f5015caa-41c8-4f82-bbef-44450f1c6ffc
    @cvs-id $Id$
} {
    return_url:notnull
} -properties {
    title:onevalue
    contex:onevalue
} -validate {
} -errors {
}

set title "[_ dotlrn.Site_Templates_Template_AdminParams]"
set context [list $title]

set dotlrn_package_id [dotlrn::get_package_id]
set template_options [db_list_of_lists select_templates {select pretty_name, site_template_id from dotlrn_site_templates}]

set user_change_p_old [parameter::get -package_id $dotlrn_package_id -parameter UserChangeSiteTemplate_p]
set user_default_p_old [parameter::get -package_id $dotlrn_package_id -parameter UserDefaultSiteTemplate_p]
set comm_change_p_old [parameter::get -package_id $dotlrn_package_id -parameter AdminChangeSiteTemplate_p]
set comm_default_p_old [parameter::get -package_id $dotlrn_package_id -parameter CommDefaultSiteTemplate_p]

ad_form -cancel_url $return_url -export { dotlrn_package_id return_url user_change_p_old user_default_p_old comm_change_p_old comm_default_p_old} -name admin-params -form {
    {user_change_p:text(radio) 
	{label "[_ dotlrn.Site_Template_Userchange]"}
	{options { {"[_ dotlrn.Yes]" 1 } { "[_ dotlrn.No]" 0} } }
	{value $user_change_p_old}
    }
    {user_default_p:text(select) 
	{label "[_ dotlrn.Site_Template_Userdefault]"}
	{options $template_options}
	{value $user_default_p_old}
    }
    {comm_change_p:text(radio) 
	{label "[_ dotlrn.Site_Template_Commchange]"}
	{options { {"[_ dotlrn.Yes]" 1 } { "[_ dotlrn.No]" 0} } }
	{value $comm_change_p_old}
    }
    {comm_default_p:text(select) 
	{label "[_ dotlrn.Site_Template_Commdefault]"}
	{options $template_options}
	{value $comm_default_p_old}
    }
    {none_default_p:text(text) 
	{label "[_ dotlrn.Site_Template_Nonedefault]"}
	{value "[parameter::get -package_id $dotlrn_package_id -parameter DefaultMaster_p]"}
	{html {size 50}}
    }
} -on_submit {
    parameter::set_value -package_id $dotlrn_package_id \
	-parameter "UserChangeSiteTemplate_p" \
	-value $user_change_p
    
    parameter::set_value -package_id $dotlrn_package_id \
	-parameter "AdminChangeSiteTemplate_p" \
	-value $comm_change_p
    
    if {$user_default_p != $user_default_p_old} {
	parameter::set_value -package_id $dotlrn_package_id \
	    -parameter "UserDefaultSiteTemplate_p" \
	    -value $user_default_p
	util_memoize_flush_regexp "get_dotlrn_master_not_cached *"
    }
    
    if {$comm_default_p != $comm_default_p_old} {
	parameter::set_value -package_id $dotlrn_package_id \
	    -parameter "CommDefaultSiteTemplate_p" \
	    -value $comm_default_p
	util_memoize_flush_regexp "get_dotlrn_master_not_cached *"
    }
    
    parameter::set_value -package_id $dotlrn_package_id \
	-parameter "DefaultMaster_p" \
	-value $none_default_p

} -after_submit {
    ad_returnredirect $return_url
    ad_script_abort
}
