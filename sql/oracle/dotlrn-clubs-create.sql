
--
-- The DotLRN basic system
-- copyright 2001, OpenForce, Inc.
-- distributed under the GNU GPL v2
--
-- for Oracle 8/8i. (We're guessing 9i works, too).
--
-- ben@openforce.net
-- started August 18th, 2001
--

create table dotlrn_clubs (
       club_id		  constraint dotlrn_club_id_fk
			  references dotlrn_communities(community_id)
			  constraint dotlrn_club_id_pk
			  primary key
);

