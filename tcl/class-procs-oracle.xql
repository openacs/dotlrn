<?xml version="1.0"?>

<queryset>
<rdbms><type>oracle</type><version>8.1.6</version></rdbms>

<fullquery name="dotlrn_class::new.create_class">
<querytext>
declare
begin
	
:1 := dotlrn_class.new (
	class_key => :name,
	pretty_name => :pretty_name,
	pretty_plural => :pretty_name,
	description => :description
);

end;
</querytext>
</fullquery>


<fullquery name="dotlrn_class::new_instance.create_class_instance">
<querytext>
declare
begin
	
:1 := dotlrn_class_instance.new (
	class_key => :class_type,
	year => :year,
	term => :term,
	community_key => :short_name,
	pretty_name => :class_name,
	description => :description
);

end;
</querytext>
</fullquery>

</queryset>
