ad_library {
    Tcl procs for interface with the site-node data model.

    @author yon@openforce.net
    @creation-date 2001-12-07
    @version $Id$
}

namespace eval site_nodes {
    ad_proc -public get_url_from_node_id {
        {-node_id:required}
    } {
        get url from node_id
    } {
        return [db_string get_url_from_node_id {
            select site_node.url(:node_id) from dual
        }]
    }

    ad_proc -public get_node_id_from_url {
        {-url:required}
        {-parent_node_id ""}
    } {
        get node_id from url
    } {
        return [db_exec_plsql get_node_id_from_url {
            begin
                :1 := site_node.node_id(url => :url, parent_id => :parent_node_id);
            end;
        }]
    }

    ad_proc -public get_parent_id {
        {-node_id:required}
    } {
        get the parent_id of this node_id
    } {
        return [db_string select_parent_site_node {}]
    }
}
