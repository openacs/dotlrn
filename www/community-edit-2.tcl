#
#  Copyright (C) 2001, 2002 OpenForce, Inc.
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
    A preview page for editing the community's header

    @author Arjun Sanyal (arjun@openforce.net)
    @version $Id$
} -query {
    {header_font ""}
    {header_font_color ""}
    {header_font_size "Normal"}
    {header_img ""}
    {header_img.tmpfile:tmpfile ""}
    {header_alt_text ""}
}


set user_id [ad_conn user_id]
set community_id [dotlrn_community::get_community_id]
dotlrn::require_user_admin_community -user_id $user_id $community_id
set page_title Preview

#   
#   # check the img if given
#   set n_bytes [file size ${header_img.tmpfile}]
#   set max_bytes [ad_parameter "MaximumFileSize"]
#   if { $n_bytes > $max_bytes } {
#       ad_complain "Your file is larger than the maximum file size allowed on this system ([util_commify_number $max_bytes] bytes)"
#   }
#   
#   # get the public folder for this comm
#   set fs_package_id [dotlrn_community::get_applet_package_id $community_id [dotlrn_fs::applet_key]]
#   set comm_root_folder_id [fs::get_root_folder -package_id $fs_package_id]
#   set folder_id [dotlrn_fs::get_public_folder_id -parent_id $comm_root_folder_id]
#   set title group_icon_3
#   set mime_type [fs_maybe_create_new_mime_type $header_img]
#   set creation_ip [ad_conn peeraddr]
#   set filename $header_img
#   ad_require_permission $folder_id write
#   if ![regexp {[^//\\]+$} $header_img filename] {
#       set filename $header_img
#   }
#   
#   # ungraciously shove this file into the public folder
#   # copied from file-storage/www/file-add-2.tcl
#   db_transaction {
#       set file_id [db_exec_plsql new_lob_file "
#       begin
#               :1 := file_storage.new_file (
#                       title => :title,
#                       folder_id => :folder_id,
#                       creation_user => :user_id,
#                       creation_ip => :creation_ip,
#                       indb_p => 't'
#                       );
#       
#       end;"]
#       
#       set version_id [db_exec_plsql new_version "
#       begin
#               :1 := file_storage.new_version (
#                       filename => :filename,
#                       description => 'the group header image',
#                       mime_type => :mime_type,
#                       item_id => :file_id,
#                       creation_user => :user_id,
#                       creation_ip => :creation_ip
#                       );
#       end;"]
#       
#       db_dml lob_content "
#       update cr_revisions
#       set    content = empty_lob()
#       where  revision_id = :version_id
#       returning content into :1" -blob_files [list ${header_img.tmpfile}]
#       
#       db_dml lob_size "
#       update cr_revisions
#       set content_length = dbms_lob.getlength(content) 
#       where revision_id = :version_id"
#   }    
#   # end copied stuff
#   

set header_text [dotlrn_community::get_community_header_name $community_id] 

if {[empty_string_p $header_font]} {
    set header_font_text "sans-serif (None chosen)"
} else {
    set header_font_text $header_font
    set header_font_fragment "$header_font, "
}
set style_fragment "font-family: $header_font_fragment Verdana, Arial, Helvetica, sans-serif;"

set header_font_size_text $header_font_size
append style_fragment "font-size: $header_font_size;"

if {[empty_string_p $header_font_color]} {
    set header_font_color_text "Black (None chosen)"
    set header_font_color "black"
} else {
    set header_font_color_text $header_font_color
}
append style_fragment " " "color: $header_font_color;"

form create header_form
set yes_label "Save and use this header"

element create header_form no_button \
    -label "Go back and try again" \
    -datatype text \
    -widget submit \
    -value "1"

element create header_form yes_button \
    -label "Save and use this header"  \
    -datatype text \
    -widget submit

element create header_form header_font \
    -label header_font \
    -datatype text \
    -widget hidden \
    -value $header_font

element create header_form header_font_size \
    -datatype text \
    -widget hidden \
    -value $header_font_size 

element create header_form header_font_color \
    -datatype text \
    -widget hidden \
    -value $header_font_color

if {[form is_valid header_form]} {
    form get_values header_form \
        no_button \
        yes_button \
        header_font \
        header_font_size \
        header_font_color

    if {[string equal $yes_button $yes_label]} {
        dotlrn_community::set_attributes \
            -community_id $community_id \
            -pairs [list \
                        [list header_font $header_font] \
                        [list header_font_size $header_font_size] \
                        [list header_font_color $header_font_color] \
                    ]
        
        ad_returnredirect "one-community-admin"
    } else {
        ad_returnredirect "community-edit"
    }
    
    ad_script_abort
}
ad_return_template
