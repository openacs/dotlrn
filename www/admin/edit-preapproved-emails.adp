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

<!--

  Copyright (C) 2001, 2002 OpenForce, Inc.

  This file is part of dotLRN.

  dotLRN is free software; you can redistribute it and/or modify it under the
  terms of the GNU General Public License as published by the Free Software
  Foundation; either version 2 of the License, or (at your option) any later
  version.

  dotLRN is distributed in the hope that it will be useful, but WITHOUT ANY
  WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
  FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more
  details.

-->

<master src="dotlrn-admin-master">
<property name="title">Edit Pre-approved Email Servers</property>
<property name="context_bar">{Edit Pre-approved Email Servers}</property>

<p>
  Email suffixes listed here are used to automatically make dotLRN users of
  people that register with email addresses that match one of the values in
  this list.
</p>

<p>
  The format of this value is a comma-separated list of domains (usually
  preceded by the *@ string which match
  &lt;anything&gt;@&lt;email-domain&gt;). For example, you might use:
  <code>*@openforce.net,*@dotlrn.openforce.net</code>
</p>

<formtemplate id="edit_emails"></formtemplate>
