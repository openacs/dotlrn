
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

create table dotlrn_classes (
       class_key		    constraint dotlrn_class_class_key_fk
				    references dotlrn_community_types(community_type)
				    constraint dotlrn_class_class_key_pk
				    primary key
);

create table dotlrn_class_instances (
       class_instance_id	    constraint dotlrn_class_i_id_fk
				    references dotlrn_communities(community_id)
				    constraint dotlrn_class_i_id_pk
				    primary key,
       class_key		    constraint dotlrn_class_i_class_key_fk
				    references dotlrn_classes(class_key)
);

