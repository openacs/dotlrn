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
    user_contributions:multirow
}

set verified_user_id [ad_verify_and_get_user_id]

# XXX add portraits to this page
set user_info_sql {
    select first_names,
           last_name,
           email,
           priv_email,
           url,
           creation_date,
           member_state
    from cc_users
    where user_id = :user_id
}

if {![db_0or1row user_information $user_info_sql]} {
    ad_return_error "No user found" "There is no community member with the user_id of $user_id"
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

set show_email_p 0
if { $priv_email <= [ad_privacy_threshold] } {
    set show_email_p 1
}

db_multirow user_contributions user_contributions {
    select acs_object_types.pretty_name,
           acs_object_types.pretty_plural,
           acs_objects.creation_date,
           acs_object.name(acs_objects.object_id) object_name
    from acs_objects,
         acs_object_types
    where acs_objects.creation_user = :user_id
    and acs_objects.object_type in ('acs_message')
    and acs_objects.object_type = acs_object_types.object_type
    order by object_name,
             creation_date
}

set context_bar [ad_context_bar_ws_or_index "Community member"]
set system_name [ad_system_name]
set pretty_creation_date [util_AnsiDatetoPrettyDate $creation_date]
set login_export_vars "return_url=[ns_urlencode [acs_community_member_url -user_id $user_id]]"

ad_return_template
