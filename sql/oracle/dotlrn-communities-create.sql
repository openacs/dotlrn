
--
-- The DotLRN communities construct
-- copyright 2001, OpenForce, Inc.
-- distributed under the GNU GPL v2
--
-- for Oracle 8/8i. (We're guessing 9i works, too).
--
-- ben@openforce.net
-- started September 20th, 2001 (redone)
--

create table dotlrn_community_types (
       community_type		    not null
				    constraint dlrn_comm_type_pk primary key
				    constraint dlrn_comm_type_fk
				    references group_types (group_type),
       pretty_name		    varchar(100) not null,
       description		    varchar(4000),
       node_id			    constraint dlrn_comm_type_node_id_fk
				    references site_nodes(node_id),
       supertype		    constraint dlrn_comm_supertype_fk
				    references dotlrn_community_types(community_type)
);
       

create table dotlrn_communities (
       community_id		not null
				constraint dlrn_comm_id_pk primary key
				constraint dlrn_comm_id_fk
				references groups(group_id),
       community_type		not null
				constraint dlrn_comm_id_type_fk
				references dotlrn_community_types(community_type),
       community_key		varchar(100) not null
				constraint dlrn_comm_key_un unique,
       pretty_name		varchar(100) not null,
       description		varchar(4000),
       node_id			constraint dlrn_comm_node_id_fk
				references site_nodes(node_id)
);


create table dotlrn_community_memberships (
       rel_id				  integer not null
					  constraint dlrn_comm_mem_fk references acs_rels(rel_id)
					  constraint dlrn_comm_mem_pk primary key,
       community_id			  integer not null
					  constraint dlrn_comm_mem_comm_id_fk references dotlrn_communities(community_id),
       user_id				  integer not null
					  constraint dlrn_comm_mem_user_id_fk references users(user_id),
       page_id				  integer not null
					  constraint dlrn_comm_mem_page_id_fk references portals(portal_id)
);					  


create table dotlrn_community_applets (
       community_id		      integer not null
				      constraint dlrn_comm_appl_comm_id_fk references dotlrn_communities(community_id),
       applet_key		      varchar(100) not null,
       constraint dlrn_comm_appl_pk primary key (community_id, applet_key),
       active_p			      char(1) default 't' not null
				      constraint dlrn_comm_appl_act_p_ch check (active_p in ('t','f'))
);
