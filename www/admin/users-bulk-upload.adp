<%

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

%>

<master src="dotlrn-admin-master">
<property name="title">Users: Bulk Upload</property>
<property name="context_bar">@context_bar@</property>

This option allows you to bulk upload a number of users from a CSV
(comma-separated values)
file. You can create a CSV file using Excel and saving it in the
correct format.

<p>

Your CSV file should have the following header titles:
<tt>first_names</tt>, <tt>last_name</tt>, <tt>email</tt>. It can also
include the following optional headers: <tt>id</tt>, <tt>type</tt> (student,
professor, admin), <tt>access_level</tt> (full, limited),
<tt>guest</tt> (t for guest, f for non-guest).

<p>

<b>Note: you will have the option of adding these users to a group
once they have been uploaded.</b>
<p>

<FORM enctype=multipart/form-data method=post action=users-bulk-upload-2>
<INPUT TYPE=file name=users_csv_file><br>
<INPUT TYPE=submit value=upload>
</FORM>
