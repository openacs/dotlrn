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
    shows User A what User B has contributed to the community

    @author yon (yon@openforce.net)
    @creation-date 2002-01-22
    @version $Id$
} {
    user_id:integer,notnull
    {community_id ""}
} -properties {
    context_bar:onevalue
    portal_id:onevalue
    member_state:onevalue
    first_names:onevalue
    last_name:onevalue
    email:onevalue
    inline_portrait_state:onevalue
    portrait_export_vars:onevalue
    width:onevalue
    height:onevalue
    system_name:onevalue
    pretty_creation_date:onevalue
    show_intranet_info_p:onevalue
    show_email_p:onevalue
    url:onevalue
    bio:onevalue
    verified_user_id:onevalue
    folder_id:onevalue
    user_contributions:multirow
}

auth::require_login

set verified_user_id [ad_verify_and_get_user_id]

set user_info_sql {
    select first_names,
           last_name,
           email,
           priv_email,
           url as homepage_url,
           creation_date,
           member_state
    from cc_users
    where user_id = :user_id
}


if {![db_0or1row user_information $user_info_sql]} {
    ad_return_error "[_ dotlrn.No_user_found]" [_ dotlrn.no_community_member_with_id [list user_id $user_id]]
    ad_script_abort
}

set bio [db_string biography {
    select attr_value
    from acs_attribute_values
    where object_id = :user_id
    and attribute_id = (select attribute_id
                        from acs_attributes
                        where object_type = 'person'
                        and attribute_name = 'bio')
} -default ""]

set weblog_p 0
if {1} {
    set weblog_package_id  [site_node_apm_integration::get_child_package_id  -package_key "forums"]
    set weblog_url "[dotlrn_community::get_url -package_id $weblog_package_id]/forum-view"
#set to check if you are using webloggers

    db_multirow weblogs weblogs {select name, forum_id, to_char(o.last_modified, 'Mon DD, YYYY') as lastest_post from forums_forums_enabled f, acs_objects o where o.object_id = forum_id 
    and o.creation_user = :user_id and f.package_id = :weblog_package_id}
    set weblog_p 1
}

set portrait_p 0
if {[ad_parameter "show_portrait_p" dotlrn]} {
    set portrait_p 1
    set inline_portrait_state ""
    set portrait_export_vars [export_vars user_id]

    set user_portrait_sql {
        select images.width,
               images.height,
               cr_revisions.title,
               cr_revisions.description,
               cr_revisions.publish_date
        from acs_rels,
             cr_items,
             cr_revisions,
             images
        where acs_rels.object_id_two = cr_items.item_id
        and cr_items.live_revision = cr_revisions.revision_id
        and cr_revisions.revision_id = images.image_id
        and acs_rels.object_id_one = :user_id
        and acs_rels.rel_type = 'user_portrait_rel'
    }

    if {[db_0or1row portrait_info $user_portrait_sql]} {
        if {![empty_string_p $width] && $width < 300 } {
            set inline_portrait_state "inline"
        } else {
            set inline_portrait_state "link"
        }
    }
}

set show_email_p 0
if { $priv_email <= [ad_privacy_threshold] } {
    set show_email_p 1
}

db_multirow user_contributions user_contributions {}

set folder_id [dotlrn_fs::get_user_shared_folder -user_id $user_id]

set scope_fs_url "/packages/file-storage/www/folder-chunk"
set n_past_days ""
set url "[site_node_object_map::get_url -object_id $folder_id]index?folder_id=$folder_id&n_past_days=99999"

set context_bar [ad_context_bar "[_ dotlrn.Community_member]"]
set system_name [ad_system_name]
set pretty_creation_date [lc_time_fmt $creation_date "%q"]
set login_export_vars "return_url=[ns_urlencode [acs_community_member_url -user_id $user_id]]"

ad_return_template

