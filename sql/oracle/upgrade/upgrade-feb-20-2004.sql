--
-- Privacy control update
-- for systems deployed on the dotlrn-2-0 branch prior
-- to February 20, 2004.
--
-- by aegrumet@alum.mit.edu on 2004-02-23
--

prompt Creating relationships, relational segments, helper views and package...
@@../privacy-init.sql
@@../privacy-package-create.sql

prompt Establishing non-guest or guest status for each user...

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
     and c.name = 'dotlrn'
     and p.name is null;

   select segment_id into v_non_guest_relseg_id
     from rel_segments
   where group_id = acs.magic_object_id('registered_users')
     and rel_type = 'dotlrn_non_guest_rel';

   select segment_id into v_guest_relseg_id
     from rel_segments
   where group_id = acs.magic_object_id('registered_users')
     and rel_type = 'dotlrn_guest_rel';

   --
   -- Convert permissions to relationships for each user.
   --

   for user in (select user_id from dotlrn_users)
   loop
     select acs_permission.permission_p(
       v_dotlrn_package_id,user.user_id,'read_private_data')
     into v_permission_p
     from dual;

     if v_permission_p = 't' then
        acs_permission.revoke_permission(
          v_dotlrn_package_id,user.user_id,'read_private_data');
        dotlrn_privacy.set_user_non_guest(user.user_id);
     else
        dotlrn_privacy.set_user_guest(user.user_id);
     end if;

   end loop;
end;
/
show errors;

prompt Granting read_private_data privilege to non-guests on each community...

declare
  v_count integer;
  v_parameter_id integer;
begin

  --
  -- Sloan-specific code.  Safe to run anywhere.
  --
  select count(*) into v_count
  from apm_parameters
  where package_key = 'dotlrn'
    and parameter_name = 'protect_private_data_p';
  if v_count > 0 then
    select parameter_id into v_parameter_id
    from apm_parameters
    where package_key = 'dotlrn'
      and parameter_name = 'protect_private_data_p';
  end if;
  --
  -- End Sloan-specific code.
  --

  for community in (select community_id, package_id from dotlrn_communities_all)
  loop

    -- Grant permission to non-guests on community.
    dotlrn_privacy.grant_rd_prv_dt_to_rel(
      community.community_id,'dotlrn_non_guest_rel');

    --
    -- Sloan-specific code.  Safe to run anywhere.
    --
    if v_count > 0 then
      for val in (
        select apm_parameter_values.attr_value
        from apm_parameter_values
        where apm_parameter_values.package_id = community.package_id
          and apm_parameter_values.parameter_id = v_parameter_id
      ) loop
        if val.attr_value = 0 then
          dotlrn_privacy.grant_rd_prv_dt_to_rel(
            community.community_id,'dotlrn_guest_rel');
        end if;   
      end loop;
    end if;
    --
    -- End Sloan-specific code.
    --

  end loop;
end;
/
show errors;

prompt Finished.

