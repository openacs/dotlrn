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
      <td>Size (bytes)</td>
      <td>Type</td>
      <td>Last Modified</td>
    </tr>
<multiple name="contents">
    <tr>
<if @contents.type@ eq "Folder">
      <td><img src="file-storage/graphics/folder.gif"></td>
      <td><a href="file-storage/index?folder_id=@contents.file_id@">@contents.name@</a></td>
      <td>&nbsp;</td>
      <td>&nbsp;</td>
      <td>Folder</td>
      <td>&nbsp;</td>
</if>
<else>
      <td><img src="file-storage/graphics/file.gif"></td>
      <td><a href="file-storage/file?file_id=@contents.file_id@">@contents.name@</a></td>
      <td><a href="file-storage/download/index?version_id=@contents.live_revision@">(download)</a></td>
      <td>@contents.content_size@</td>
      <td>@contents.type@</td>
      <td>@contents.last_modified@</td>
</else>
  </tr>
</multiple>
  </table>
</if>
<else>
  <p><blockquote><i>Folder @folder_name@ is empty</i></blockquote></p>
</else>
