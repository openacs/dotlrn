# packages/dotlrn/lib/facilitator-bio.tcl
#
# one chunk of facilitator bio
#
# @author Deds Castillo (deds@i-manila.com.ph)
# @creation-date 2005-04-11
# @arch-tag: c07cafa9-3074-485a-a545-cbdd8b01c4f2
# @cvs-id $Id$

foreach required_param {user_id} {
    if {![info exists $required_param]} {
        return -code error "$required_param is a required parameter."
    }
}
foreach optional_param {return_url} {
    if {![info exists $optional_param]} {
        set $optional_param {}
    }
}

set my_user_id [ad_conn user_id]

if {![exists_and_not_null community_id]} {
    set community_id [dotlrn_community::get_community_id]
}

set facilitator_p [dotlrn::user_can_admin_community_p \
                       -user_id $my_user_id \
                       -community_id $community_id]

#if {!$facilitator_p} {
#    set user_id 0
#    ad_return_template
#}

acs_user::get -user_id $user_id -array user -include_bio

if {![db_0or1row get_item_id {
    select live_revision as revision_id, item_id
    from acs_rels a, cr_items c
    where a.object_id_two = c.item_id
    and a.object_id_one = :user_id
    and a.rel_type = 'user_portrait_rel'
}] || [empty_string_p $revision_id]} {
    # The user doesn't have a portrait yet
    set portrait_p 0
} else {
    set portrait_p 1
}

if {$portrait_p} {
    if [catch {db_1row get_picture_info "
        select i.width, i.height, cr.title, cr.description, cr.publish_date
        from images i, cr_revisions cr
        where i.image_id = cr.revision_id
        and image_id = :revision_id
    "} errmsg] {
        set portrait_p 0
    }
    
    if [empty_string_p $publish_date] {
        set portrait_p 0
    }

    if { ![empty_string_p $width] && ![empty_string_p $height] } {
        set widthheight "width=$width height=$height"
    } else {
        set widthheight ""
    }
    set export_vars "user_id=$user_id"
}

if {[string equal $my_user_id $user_id] || $facilitator_p} {
    if {[empty_string_p $community_id]} {
        set edit_bio_url [export_vars -base "bio-update" {return_url user_id}]
    } else {
        set edit_bio_url [export_vars -base "[dotlrn_community::get_community_url $community_id]bio-update" {return_url user_id}]
    }
}
