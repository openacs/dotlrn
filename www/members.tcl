#
#  Copyright (C) 2001, 2002 MIT
#
#  This file is part of dotLRN.
#
#  dotLRN is free software; you can redistribute it and/or modify it under the
#  terms of the GNU General Public License as published by the Free Software
#  Foundation; either version 2 of the License, or (at your option) any later
#  version.
#
#  dotLRN is distributed in the hope that it will be useful, but WITHOUT ANY
#  WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
#  FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more
#  details.
#

ad_page_contract {

    @author nimam (mazloumi@uni-mannheim.de)
    @creation-date Oct 05, 2004
    @version $Id$

} {
    {orderby:optional}
    {csv:optional}
    {reset:optional}
    {reltype:optional}
}

set my_user_id [ad_conn user_id]
set context [list [list "one-community-admin" [_ dotlrn.Admin]] [_ dotlrn.Manage_Members]]
set community_id [dotlrn_community::get_community_id]
set spam_p [dotlrn::user_can_spam_community_p -user_id [ad_get_user_id] -community_id $community_id]
set referer [ns_conn url]
set return_url "[ns_conn url]?[ns_conn query]"

set site_wide_admin_p [permission::permission_p -object_id [acs_magic_object security_context_root]  -privilege admin]

if {!$site_wide_admin_p} {
    set admin_p [dotlrn::user_can_admin_community_p -user_id $my_user_id -community_id $community_id]
} else {
    set admin_p 1
}

# make it so that only course admins 
# and site wide admins can read this page 
# if { !$admin_p } {
#        ad_return_forbidden  "Permission Denied"  "<blockquote>
#    You don't have permission to view this page.
#    </blockquote>"
#        ad_script_abort
#}

if {$admin_p} {
    set add_member_url [export_vars -base user-add { {can_browse_p 1} {read_private_data_p t} {referer $return_url} }]
}

if {![exists_and_not_null referer]} {
    if {[string equal $admin_p t] == 1} {
        set referer "one-community-admin"
    } else {
        set referer "one-community"
    }
}

set bio_attribute_id [db_string bio_attribute_id {
    select attribute_id                           
    from acs_attributes                           
    where object_type = 'person'                  
    and attribute_name = 'bio'                    
}]    

# Actions for Removing Members according to their role
set rel_types [dotlrn_community::get_roles -community_id $community_id]

set bulk_actions ""
set bulk_actions_export_vars ""
set actions ""

if {$admin_p} {
    set bulk_actions [list "[_ dotlrn.Drop_Membership]" "deregister" "[_ dotlrn.Drop_Membership]"]
    set bulk_actions_export_vars [list "user_id" "referer" "reset"]
    set actions [list "CSV" "members?csv=yes" "[_ dotlrn.Comma_Separated_Values]"]
    foreach role $rel_types {
		# lappend actions "[_ dotlrn.Remove_all] [lang::util::localize [lindex $role 3]]" "members?reset=1&reltype=[lindex $role 0]" "[lang::util::localize [lindex $role 2]]"
		lappend actions "[_ dotlrn.Remove_all] [lang::util::localize [lindex $role 3]]" "member-confirm?reset=1&reltype=[lindex $role 0]" "[lang::util::localize [lindex $role 2]]"
    }
}

# Set the elements list
set elm_list {
        portrait {
            label ""
            html "align right"
            display_template {
		<if @members.portrait_p@ true or @members.bio_p@ true>
		<a href="@members.member_url@">
		<img src="/resources/acs-subsite/profile-16.png" height="16" width="16" alt="#acs-subsite.Profile#" title="#acs-subsite.lt_User_has_portrait_title#" border="0">
		</a>
		</if>
		<if @members.update_bio_p@ eq 1>
                <br><a href=bio-update?user_id=@members.user_id@&return_url=$return_url>Update bio</a>
		</if>

            }
        } last_name {
            label "[_ acs-subsite.Last_name]"
            html "align left"
	    display_template {
		<a href="@members.member_url@">@members.last_name;noquote@</a>
	    }
        } first_names {
            label "[_ acs-subsite.First_names]"
            html "align left"
	    display_template {
		<a href="@members.member_url@">@members.first_names@</a>
	    }
        } email {
	    label "[_ dotlrn.Email_1]"
	    html "align left"
	    display_template {
		<a href="mailto:@members.email@">@members.email@</a>
	    }
	} role {
	    label "[_ dotlrn.Role]"
	    html "align left"
	} 
}

if {$admin_p} {
    lappend elm_list {action} {
	    label "[_ dotlrn.Actions]"
	    html "align left"
	    display_template {
		<if @members.user_id@ ne \"\">
		<a href="member-confirm?user_id=@members.user_id@&referer=@members.member_referer@">#dotlrn.Drop_Membership#</a> | 
		<a href="member-add-2?user_id=@members.user_id@&referer=@members.member_referer@">#dotlrn.User_Admin_Page#</a>
		</if>
	    }
	}
}

# Build the list-builder list
template::list::create -name members -multirow members -key user_id -actions $actions -bulk_actions $bulk_actions -bulk_action_export_vars $bulk_actions_export_vars -elements $elm_list -orderby {
	last_name {orderby last_name}
	first_names {orderby first_names}
	email {orderby email}
	role {orderby role}
} -selected_format csv -formats {
	csv { output csv }
}

set orderby [template::list::orderby_clause -name "members" -orderby]

set member_page [acs_community_member_page]

db_multirow -extend { update_bio_p member_url member_referer } members select_current_members {} {
    set member_url "$member_page?user_id=$user_id"
    set member_referer $referer

    set update_bio_p $admin_p
    set role [dotlrn_community::get_role_pretty_name -community_id $community_id -rel_type $rel_type]
}

if { [exists_and_not_null csv] } {
    template::list::write_output -name members
}

# # Bulk action User Admin Page
# # Depending on the community_type, we have allowable rel_types
# set rel_types [dotlrn_community::get_roles -community_id $community_id]
# set selection "<select name=\"rel_type\">"
# foreach role $rel_types {
#     append selection "<option value=\"[lindex $role 0]\">[lang::util::localize [lindex $role 2]]</option>"
# }
# append selection "</select>"
# set size [multirow size members]
# if { $size > 0 } {
#     multirow append members "" "" "" "" "" $selection
# }

set user_ids ""
db_multirow -extend { member_url pending_user_referer } pending_users select_pending_users {} {
    set role [dotlrn_community::get_role_pretty_name -community_id $community_id -rel_type $rel_type]
    append user_ids "user_id=$user_id&"
    set member_url "$member_page?user_id=$user_id"
    set pending_user_referer $referer
}


if {$admin_p} {
    if { [template::multirow size pending_users] > 0 } {
	set pend_actions [list "[_ dotlrn.Approve_all]" "approve?${user_ids}referer=$referer" "[_ dotlrn.Approve_all]" \
			      "[_ dotlrn.Reject_all]" "reject?${user_ids}referer=$referer" "[_ dotlrn.Reject_all]"]
    } else {
	set pend_actions ""
    }
} else {
    set pend_actions ""
}

template::list::create -name pending_users -multirow pending_users -key user_id -actions $pend_actions -elements {
    last_name {
	label "[_ acs-subsite.Last_name]"
            html "align left"
	display_template {
	    <a href="@pending_users.member_url@">@pending_users.last_name;noquote@</a>
	}
    } first_names {
	label "[_ acs-subsite.First_names]"
            html "align left"
	display_template {
                <a href="@pending_users.member_url@">@pending_users.first_names@</a>
	}
    } email {
	label "[_ dotlrn.Email_1]"
            html "align left"
	display_template {
                <a href="mailto:@pending_users.email@">@pending_users.email@</a>
	}
    } role {
	label "[_ dotlrn.Role]"
            html "align left"
    } action {
	label "[_ dotlrn.Actions]"
            html "align left"
	display_template {
                <a href="approve?user_id=@pending_users.user_id@&referer=@pending_users.pending_user_referer@">#dotlrn.Approve#</a> |
                <a href="reject?user_id=@pending_users.user_id@&referer=@pending_users.pending_user_referer@">#dotlrn.Reject#</a>
	}
    }
}

set subcomm_p [dotlrn_community::subcommunity_p -community_id $community_id]

if {$subcomm_p} {

    form create parent_users_form

    set parent_user_list [dotlrn_community::list_possible_subcomm_users -subcomm_id $community_id]
    set n_parent_users [llength $parent_user_list]

    foreach user $parent_user_list {
        element create parent_users_form "selected_user.[ns_set get $user user_id]" -datatype text -widget radio -options {{{} none} {{} dotlrn_member_rel} {{} dotlrn_admin_rel}} -value none
    }

    if {[form is_valid parent_users_form]} {
	set user_ids_to_email [list]
        foreach user $parent_user_list {
            set rel [element get_value parent_users_form "selected_user.[ns_set get $user user_id]"]

            if {![string match $rel none]} {
                dotlrn_community::add_user -rel_type $rel $community_id [ns_set get $user user_id]
		lappend user_ids_to_email [ns_set get $user user_id]
            }
        }
	if {[llength $user_ids_to_email]} {
	    set return_url [export_vars -base member-email-confirm {{user_id $user_ids_to_email} community_id}]
	} else {
	    set return_url [ns_conn url]
	}
        ad_returnredirect $return_url
    }

}

if {[exists_and_not_null reset] && [exists_and_not_null reltype]} {
set result ""
    db_multirow reset_members select_members {} {
	rp_form_put user_id $member_id
    }
    rp_form_put referer "one-community"
    rp_form_put community_id $community_id
    rp_internal_redirect "deregister"
}

ad_return_template
