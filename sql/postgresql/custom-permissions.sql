-- @author Don Baccus
-- @creation-date 2002-07-09
--
-- Ported from oracle 2002-08-10 davis@xarg.net
--
-- Return 't' if the party has admin privileges on the given group
-- This function is much faster than the general permissions permission_p
-- function as it takes advantage of the fact that we know the object
-- being checked is a group.   This allows us to greatly simplify the relseg
-- check.

-- We also don't bother checking to see if "The Public" (all visitors) or
-- "Registered Users" are allowed to admin the dotLRN community because, well,
-- we know they aren't.


-- We also don't check to see if the group has the direct admin perm on 
-- the object because dotLRN puts all group-level admins into a relational
-- segment with the 'admin' privilege on its parent group.


-- If you customize the dotLRN community datamodel and violate any of the
-- above assumptions, rewrite this function.


create or replace function dotlrn_community_admin_p (integer, integer)
returns char as '
  declare 
       group_id alias for $1;
       party_id alias for $2;
  begin
    --
    -- direct permissions
    if exists (
        select 1
          from acs_object_grantee_priv_map
         where object_id = dotlrn_community_admin_p.group_id
           and grantee_id = dotlrn_community_admin_p.party_id
           and privilege = ''admin'')
    then 
        return ''t'';
    end if;       

    -- check to see if the user belongs to a rel seg that has
    -- the admin priv on the object (in this case a group)


    if exists (
        select 1
        from acs_object_grantee_priv_map ogpm,
          rel_seg_approved_member_map rs
        where rs.group_id = dotlrn_community_admin_p.group_id
          and ogpm.object_id = rs.group_id
          and ogpm.privilege = ''admin''
          and ogpm.grantee_id = rs.segment_id
          and rs.member_id = dotlrn_community_admin_p.party_id)
    then
        return ''t'';
    end if;

    return ''f'';
end;' language 'plpgsql';
