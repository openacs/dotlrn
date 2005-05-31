<br clear="all" />
<br />
<if @user_id@>
<h3>@user.name;noquote@
<if @user_id@ eq @my_user_id@>
<a href="@edit_bio_url;noquote@" class="button">Edit My Bio</a>
</if>
</h3>

<br />
<if @portrait_p@>
<img @widthheight@ src="/shared/portrait-bits.tcl?@export_vars@" alt="Portrait of @user.name@" align="left" style="padding-right: 10px;">
</if>
@user.bio;noquote@
</if>
