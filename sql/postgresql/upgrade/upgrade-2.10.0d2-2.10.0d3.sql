begin;

    -- dotlrn_communities is a view and cannot be used as
    -- table_name. I know there are cases downstream where
    -- dotlrn_communities_all is also a view, but at least here on
    -- valilla it's a table.
    update acs_object_types set
       table_name = 'dotlrn_communities_all'
     where object_type = 'dotlrn_community';

    update acs_object_types set
       table_name = 'dotlrn_class_instances'
     where object_type = 'dotlrn_class_instance';

    update acs_object_types set
       table_name = 'dotlrn_clubs'
     where object_type = 'dotlrn_club';

    -- Tables defined for these objects don't really exist, as they
    -- are just plain relational segments without additional
    -- meatadata.
    update acs_object_types set
       table_name = null, id_column = null
     where object_type = 'dotlrn_guest_rel';

    update acs_object_types set
       table_name = null, id_column = null
     where object_type = 'dotlrn_non_guest_rel';
    -- ----

end;
