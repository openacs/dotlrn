<?xml version="1.0"?>

<queryset>
<rdbms><type>oracle</type><version>8.1.6</version></rdbms>

<fullquery name="dotlrn::user_add.add_user">
<querytext>
declare
begin
:1 := dotlrn_user.new(:user_id, :role);
end;
</querytext>
</fullquery>

</queryset>
