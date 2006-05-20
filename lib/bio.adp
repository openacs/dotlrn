<br clear="all" />
<br />
<if @user_id@>
<h3>@user.name;noquote@
<if @edit_bio_url@ not nil>
<a href="@edit_bio_url;noquote@" class="button">#dotlrn.Edit_Biography#</a>
</if>
</h3>

<br />
<if @portrait_p@>
<img @widthheight@ src="/shared/portrait-bits.tcl?@export_vars@" alt="Portrait of @user.name@" align="left" style="padding-right: 10px;">
</if>
@user.bio;noquote@
</if>
