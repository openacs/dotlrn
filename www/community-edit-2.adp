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

<master src="dotlrn-master">
<property name="title">@page_title@</property>

<ul>
  <li>#dotlrn.Header_Font#: @header_font_text@
  <li>#dotlrn.Header_Font_Size#: @header_font_size_text@
  <li>#dotlrn.Header_Font_Color#: @header_font_color_text@
  <li>#dotlrn.Header_Icon_Alt_Text#: @header_alt_text@
</ul>


#dotlrn.lt_this_is_what_the_header#:

<hr>
<div style="@style_fragment@">
<img src=community-image?revision_id=@revision_id@ alt="@header_alt_text@" border=0>&nbsp;&nbsp;@header_text@
</div>
<hr>

<p>
  <formtemplate id="header_form"></formtemplate>
</p>

<br>
<p>
#dotlrn.lt_having_trouble#:

<ul>
  <li>#dotlrn.lt_if_you_misspell#

  <li>#dotlrn.You_can_specify_colors_by_name#
  (<strong><span style="color: aqua; background: white">#dotlrn.aqua#</span>,
  <span style="color: black; background: white">#dotlrn.black#</span>, 
  <span style="color: blue; background: white">#dotlrn.blue#</span>,
  <span style="color: fuchsia; background: white">#dotlrn.fuchsia#</span>,
  <span style="color: gray; background: white">#dotlrn.gray#</span>,
  <span style="color: green; background: white">#dotlrn.green#</span>,
  <span style="color: lime; background: white">#dotlrn.lime#</span>,
  <span style="color: maroon; background: white">#dotlrn.maroon#</span>,
  <span style="color: navy; background: white">#dotlrn.navy#</span>,
  <span style="color: olive; background: white">#dotlrn.olive#</span>,
  <span style="color: purple; background: white">#dotlrn.purple#</span>,
  <span style="color: red; background: white">#dotlrn.red#</span>,
  <span style="color: silver; background: white">#dotlrn.silver#</span>,
  <span style="color: teal; background: white">#dotlrn.teal#</span>) 
  </strong>
  <br>
  #dotlrn.or_by_RGB_number# (<strong>##dotlrn.rrggbb#</strong>).
</ul>

