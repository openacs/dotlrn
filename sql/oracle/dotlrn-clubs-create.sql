
--
-- The DotLRN basic system
-- copyright 2001, OpenForce, Inc.
-- distributed under the GNU GPL v2
--
-- for Oracle 8/8i. (We're guessing 9i works, too).
--
-- @author Ben Adida (ben@openforce.net)
-- @author yon (yon@openforce.net)
-- @creation-date August 18th, 2001
-- @version $Id$
--

create table dotlrn_clubs (
    club_id                     constraint dotlrn_clubs_club_id_fk
                                references dotlrn_communities (community_id)
                                constraint dotlrn_clubs_pk
                                primary key
);

create or replace view dotlrn_clubs_full
as
    select dotlrn_clubs.club_id,
           dotlrn_communities.community_type,
           dotlrn_communities.community_key,
           dotlrn_communities.pretty_name,
           dotlrn_communities.description,
           dotlrn_communities.active_start_date,
           dotlrn_communities.active_end_date,
           dotlrn_communities.portal_id,
           dotlrn_communities.portal_template_id,
           dotlrn_communities.package_id,
           dotlrn_community.url(dotlrn_communities.community_id) as url,
           groups.join_policy
    from dotlrn_communities,
         dotlrn_clubs,
         groups
    where dotlrn_communities.community_id = dotlrn_clubs.club_id
    and dotlrn_communities.community_id = groups.group_id;

create or replace package dotlrn_club
is
    function new (
        club_id in dotlrn_clubs.club_id%TYPE default null,
        community_key in dotlrn_communities.community_key%TYPE,
        pretty_name in dotlrn_communities.pretty_name%TYPE,
        description in dotlrn_communities.description%TYPE,
        package_id in dotlrn_communities.package_id%TYPE default null,
        portal_id in dotlrn_communities.portal_id%TYPE default null,
        portal_template_id in dotlrn_communities.portal_template_id%TYPE default null,
        join_policy in groups.join_policy%TYPE default null,
        creation_date in acs_objects.creation_date%TYPE default sysdate,
        creation_user in acs_objects.creation_user%TYPE default null,
        creation_ip in acs_objects.creation_ip%TYPE default null,
        context_id in acs_objects.context_id%TYPE default null
    ) return dotlrn_clubs.club_id%TYPE;

    procedure delete (
        club_id in dotlrn_clubs.club_id%TYPE
    );
end;
/
show errors

create or replace package body dotlrn_club
is
    function new (
        club_id in dotlrn_clubs.club_id%TYPE default null,
        community_key in dotlrn_communities.community_key%TYPE,
        pretty_name in dotlrn_communities.pretty_name%TYPE,
        description in dotlrn_communities.description%TYPE,
        package_id in dotlrn_communities.package_id%TYPE default null,
        portal_id in dotlrn_communities.portal_id%TYPE default null,
        portal_template_id in dotlrn_communities.portal_template_id%TYPE default null,
        join_policy in groups.join_policy%TYPE default null,
        creation_date in acs_objects.creation_date%TYPE default sysdate,
        creation_user in acs_objects.creation_user%TYPE default null,
        creation_ip in acs_objects.creation_ip%TYPE default null,
        context_id in acs_objects.context_id%TYPE default null
    ) return dotlrn_clubs.club_id%TYPE
    is
        v_club_id integer;
    begin
        v_club_id := dotlrn_community.new(
            community_id => club_id,
            community_type => 'dotlrn_club',
            community_key => community_key,
            pretty_name => pretty_name,
            description => description,
            package_id => package_id,
            portal_id => portal_id,
            portal_template_id => portal_template_id,
            join_policy => join_policy,
            creation_date => creation_date,
            creation_user => creation_user,
            creation_ip => creation_ip,
            context_id => context_id
        );

        insert
        into dotlrn_clubs (club_id)
        values (v_club_id);

        return v_club_id;
    end;

    procedure delete (
        club_id in dotlrn_clubs.club_id%TYPE
    )
    is
    begin
        delete
        from dotlrn_clubs
        where club_id = dotlrn_club.delete.club_id;

        dotlrn_community.delete(community_id => club_id);
    end;
end;
/
show errors
