--
-- Privacy control update
-- for systems upgrading to 2.0 from
-- code olderthan February 20, 2004.
--
-- by aegrumet@alum.mit.edu on 2004-02-23
--

prompt Creating relationships, relational segments, helper views and package...
\i ../privacy-init.sql
\i ../privacy-package-create.sql

-- prompt Establishing non-guest or guest status for each user...

create function inline_1()
returns integer as '
declare
   v_dotlrn_package_id integer;
   v_permission_p char(1);
   v_non_guest_relseg_id integer;
   v_guest_relseg_id integer;
begin

   --
   -- Load some constants.
   --

   -- Assume, as in dotlrn::package_key, that dotlrn is mounted at /dotlrn.
   select c.object_id into v_dotlrn_package_id
   from site_nodes c, site_nodes p
   where p.node_id = c.parent_id
     and c.name = ''dotlrn''
     and p.name is null;

   select segment_id into v_non_guest_relseg_id
     from rel_segments
   where group_id = acs__magic_object_id(''registered_users'')
     and rel_type = ''dotlrn_non_guest_rel'';

   select segment_id into v_guest_relseg_id
     from rel_segments
   where group_id = acs__magic_object_id(''registered_users'')
     and rel_type = ''dotlrn_guest_rel'';

   --
   -- Convert permissions to relationships for each user.
   --

   for user in select user_id from dotlrn_users
   loop
     select acs_permission__permission_p(
       v_dotlrn_package_id,user.user_id,''read_private_data'')
     into v_permission_p
     from dual;

     if v_permission_p = ''t'' then
        acs_permission__revoke_permission(
          v_dotlrn_package_id,user.user_id,''read_private_data'');
        dotlrn_privacy__set_user_non_guest(user.user_id);
     else
        dotlrn_privacy__set_user_guest(user.user_id);
     end if;

    end loop;

    return(0);
end;
' language 'plpgsql';

select inline_1();
drop function inline_1();


-- prompt Granting read_private_data privilege to non-guests on each community...

create function inline_1()
returns integer as '
declare
  v_count integer;
  v_parameter_id integer;
begin

  for community in select community_id, package_id from dotlrn_communities_all
  loop

    -- Grant permission to non-guests on community.
    dotlrn_privacy__grant_rd_prv_dt_to_rel(
      community.community_id,''dotlrn_non_guest_rel'');

  end loop;

  return(0);

end;
' language 'plpgsql';

select inline_1();
drop function inline_1();

-- prompt Finished.

