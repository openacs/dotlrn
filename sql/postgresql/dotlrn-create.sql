
--
-- The DotLRN basic system
-- copyright 2001, OpenForce, Inc.
-- distributed under the GNU GPL v2
--
-- ben@openforce.net
-- for PostgreSQL 7.1.2 and above
--
-- started August 18th, 2001
--



-- Since a lot of stuff needs to happen to set up a group type,
-- this isn't going to be done at the data model level, it's going to
-- be done in Tcl. Woohoo.


-- We do need some basic data model to represent classes, class instances
-- and the associated information there

create table dotlrn_classes (
       class_key		    varchar(100) not null 
				    constraint dotlrn_class_class_key_fk
				    references group_types(group_type)
				    constraint dotlrn_class_class_key_pk
				    primary key,
       node_id			    integer not null
				    constraint dotlrn_class_node_id_fk
				    references site_nodes (node_id)
);

create table dotlrn_class_instances (
       class_instance_id	    integer not null
				    constraint dotlrn_class_inst_id_fk
				    references groups(group_id)
				    constraint dotlrn_class_inst_id_pk
				    primary key,
       class_instance_key	    varchar(100) not null 
				    constraint dotlrn_class_inst_key_un unique,
       class_key		    varchar(100) not null
				    constraint dotlrn_class_inst_class_key_fk
				    references dotlrn_classes(class_key),
       node_id			    integer not null
				    constraint dotlrn_class_inst_node_id_fk
				    references site_nodes(node_id)
);

create table dotlrn_class_inst_applets (
       class_instance_id	    integer not null
				    constraint dotlrn_class_inst_app_inst_fk
				    references dotlrn_class_instances(class_instance_id),
       applet			    varchar(200) not null,
       constraint dotlrn_class_inst_app_pk primary key (class_instance_id, applet),
       node_id		            integer not null
				    constraint dotlrn_class_inst_app_node_id_fk
				    references site_nodes(node_id)
);
