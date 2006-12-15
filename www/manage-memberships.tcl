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

# dotlrn/www/manage-memberships.tcl

ad_page_contract {
    @author yon (yon@openforce.net)
    @creation-date 2002-03-08
} -query {
    {member_department_key ""}
    {non_member_department_key ""}
    {member_term_id -1}
    {non_member_term_id -1}
} -properties {
}

if { ! [parameter::get -parameter SelfRegistrationP -package_id [dotlrn::get_package_id] -default 1] } {
    set redirect_to [parameter::get -parameter SelfRegistrationRedirectTo -package_id [dotlrn::get_package_id] -default ""]

    if { $redirect_to ne "" } {
	ad_returnredirect $redirect_to
    } else {
	ad_returnredirect "not-allowed"
    }
    ad_script_abort
}

set user_id [ad_conn user_id]

set show_drop_button_p [parameter::get_from_package_key \
                               -package_key dotlrn-portlet \
			       -parameter AllowMembersDropGroups]

if {![dotlrn::user_can_browse_p]} {
    ad_returnredirect "not-allowed"
    ad_script_abort
}

set departments [db_list_of_lists select_departments_for_select_widget {
    select dotlrn_departments_full.pretty_name,
           dotlrn_departments_full.department_key
    from dotlrn_departments_full
    order by dotlrn_departments_full.pretty_name,
             dotlrn_departments_full.department_key
}]
set departments [linsert $departments 0 {All ""}]
set departments_pretty_name [parameter::get -localize -parameter departments_pretty_name]

set terms [db_list_of_lists select_terms_for_select_widget {
    select dotlrn_terms.term_name || ' ' || dotlrn_terms.term_year,
           dotlrn_terms.term_id
    from dotlrn_terms
    order by dotlrn_terms.start_date,
             dotlrn_terms.end_date
}]
set terms [linsert $terms 0 {All -1}]

form create member_form

element create member_form member_department_key \
    -label "[_ dotlrn.Department]" \
    -datatype text \
    -widget select \
    -options $departments \
    -html {onChange document.member_form.submit()} \
    -value $member_department_key

element create member_form member_term_id \
    -label "[_ dotlrn.Term]" \
    -datatype integer \
    -widget select \
    -options $terms \
    -html {onChange document.member_form.submit()} \
    -value $member_term_id

element create member_form non_member_department_key \
    -label "[_ dotlrn.Department]" \
    -datatype text \
    -widget hidden \
    -value $non_member_department_key

element create member_form non_member_term_id \
    -label "[_ dotlrn.Term]" \
    -datatype text \
    -widget hidden \
    -value $non_member_term_id

if {[form is_valid member_form]} {
    form get_values member_form \
        member_department_key member_term_id \
        non_member_department_key non_member_term_id
}

set member_query "select_member_classes"

if {![empty_string_p $member_department_key]} {
    append member_query "_by_department"
}

if {$member_term_id != -1} {
    append member_query "_by_term"
}

set n_member_classes [db_string select_n_member_classes {}]

db_multirow member_classes $member_query {} {
    set role [template::util::nvl [dotlrn_community::get_role_pretty_name -community_id $class_instance_id -rel_type $rel_type] [_ dotlrn.student_role_pretty_name]]
}

db_multirow member_clubs select_member_clubs {} {
    set role [dotlrn_community::get_role_pretty_name -community_id $club_id -rel_type $rel_type]
}

form create non_member_form

element create non_member_form non_member_department_key \
    -label "[_ dotlrn.Department]" \
    -datatype text \
    -widget select \
    -options $departments \
    -html {onChange document.non_member_form.submit()} \
    -value $non_member_department_key

element create non_member_form non_member_term_id \
    -label "[_ dotlrn.Term]" \
    -datatype integer \
    -widget select \
    -options $terms \
    -html {onChange document.non_member_form.submit()} \
    -value $non_member_term_id

element create non_member_form member_department_key \
    -label "[_ dotlrn.Department]" \
    -datatype text \
    -widget hidden \
    -value $member_department_key

element create non_member_form member_term_id \
    -label "[_ dotlrn.Term]" \
    -datatype text \
    -widget hidden \
    -value $member_term_id

if {[form is_valid non_member_form]} {
    form get_values non_member_form \
        non_member_department_key non_member_term_id \
        member_department_key member_term_id
}

set non_member_query "select_non_member_classes"

if {![empty_string_p $non_member_department_key]} {
    append non_member_query "_by_department"
}

if {$non_member_term_id != -1} {
    append non_member_query "_by_term"
}

# Is the user a .LRN admin or a sitewide admin
set swa_p [acs_user::site_wide_admin_p -user_id $user_id] 
if {!$swa_p} {
    set swa_p [dotlrn::admin_p -user_id $user_id]
}

set n_non_member_classes [db_string select_n_non_member_classes {}]
db_multirow non_member_classes $non_member_query {} {
    regsub -all {<p>} $description {<br />} description
}

db_multirow non_member_clubs select_non_member_clubs {} {
    regsub -all {<p>} $description {<br />} description
}
    

# hack for eabis
set non_member_club_ids [db_list non_member_club_ids {                select f.club_id
                from dotlrn_clubs_full f
                where f.join_policy <> 'closed'
                  and f.club_id not in (select dotlrn_member_rels_full.community_id as club_id
                                          from dotlrn_member_rels_full
                                         where dotlrn_member_rels_full.user_id = :user_id)
}]

set referer [ns_urlencode "[ns_conn url]?[export_vars {member_department_key member_term_id non_member_department_key non_member_term_id}]"]

# en_US messages make use of these configurable pretty names
set clubs_pretty_plural [parameter::get -localize -parameter clubs_pretty_plural]
set class_instances_pretty_name [parameter::get -localize -parameter class_instances_pretty_name]
set clubs_pretty_name [parameter::get -localize -parameter clubs_pretty_name]

ad_return_template
