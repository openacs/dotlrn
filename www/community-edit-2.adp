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
  <li>Header Font: @header_font_text@
  <li>Header Font Size: @header_font_size_text@
  <li>Header Font Color: @header_font_color_text@
  <li>Header Icon Alt Text: @header_alt_text@
</ul>


This is what the header will look like:

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
Having trouble getting the look you want? Here's some tips:

<ul>
  <li>If you misspell the font name or pick a font that a user doesn't
  have on her computer, the normal system font will be used.   

  <li>You can specify colors by name 
  (<strong><span style="color: aqua; background: white">aqua</span>,
  <span style="color: black; background: white">black</span>, 
  <span style="color: blue; background: white">blue</span>,
  <span style="color: fuchsia; background: white">fuchsia</span>,
  <span style="color: gray; background: white">gray</span>,
  <span style="color: green; background: white">green</span>,
  <span style="color: lime; background: white">lime</span>,
  <span style="color: maroon; background: white">maroon</span>,
  <span style="color: navy; background: white">navy</span>,
  <span style="color: olive; background: white">olive</span>,
  <span style="color: purple; background: white">purple</span>,
  <span style="color: red; background: white">red</span>,
  <span style="color: silver; background: white">silver</span>,
  <span style="color: teal; background: white">teal</span>) 
  </strong>
  <br>
  or by RGB number (<strong>#rrggbb</strong>).
</ul>
