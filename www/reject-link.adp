 <a href="<if @url@ nil>reject<if @referer@ not nil>?referer=@referer@</if></if><else>@url@<if @referer@ not nil>?referer=@referer@</if></else>"><if @label@ nil>Reject</if><else>@label@</else></a>
