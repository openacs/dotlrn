<%

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

%>

<if @contents:rowcount@ gt 0>
  <table width="85%" cellpadding="5" cellspacing="5">
    <tr>
      <td>&nbsp;</td>
      <td>Name</td>
      <td>Action</td>
      <td>Size</td>
      <td>Type</td>
      <td>Last Modified</td>
    </tr>
<multiple name="contents">
    <tr>
<if @contents.type@ eq "Folder">
      <td><img src="graphics/folder.gif"></td>
      <td>
        <a href="index?folder_id=@contents.object_id@&n_past_days=@n_past_days@">@contents.name@</a>
<if @contents.new_p@ and @contents.content_size@ gt 0>(&nbsp;new&nbsp;)</if>
      </td>
      <td>&nbsp;</td>
      <td>
        @contents.content_size@ item<if @contents.content_size@ ne 1>s</if>
      </td>
      <td>@contents.type@</td>
      <td>@contents.last_modified@</td>
</if>
<else>
<if @contents.type@ eq "URL">
      <td><img src="graphics/file.gif"></td>
      <td>
      <a href="url-goto?url_id=@contents.object_id@">@contents.name@</a>
<if @contents.new_p@>(&nbsp;new&nbsp;)</if>
      </td>
      <td>
        [&nbsp;<small><if @contents.write_p@ or @contents.admin_p@><a href="simple-edit?object_id=@contents.object_id@">edit</a></if><if @contents.delete_p@ or @contents.admin_p@>&nbsp;|&nbsp;<a href="simple-delete?folder_id=@folder_id@&object_id=@contents.object_id@">delete</a></if></small>&nbsp;]
      </td>
      <td>&nbsp;</td>
      <td>@contents.type@</td>
      <td>@contents.last_modified@</td>
</if>
<else>
      <td><img src="graphics/file.gif"></td>
      <td>
      <a href="file?file_id=@contents.object_id@">@contents.name@</a>
<if @contents.new_p@>(&nbsp;new&nbsp;)</if>
      </td>
      <td>
        [&nbsp;<small><a href="download/index?version_id=@contents.live_revision@">download</a><if @contents.delete_p@ or @contents.admin_p@>&nbsp;|&nbsp;<a href="file-delete?file_id=@contents.object_id@">delete</a></if></small>&nbsp;]
      </td>
      <td>@contents.content_size@ byte<if @contents.content_size@ ne 1>s</if></td>
      <td>@contents.type@</td>
      <td>@contents.last_modified@</td>
</else>
</else>
  </tr>
</multiple>
  </table>
</if>
<else>
  <p><blockquote><i>Folder @folder_name@ is empty</i></blockquote></p>
</else>
