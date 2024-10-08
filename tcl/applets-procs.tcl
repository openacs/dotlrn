#
#  Copyright (C) 2001, 2002 MIT
#
#  This file is part of dotLRN.
#
#  dotLRN is free software; you can redistribute it and/or modify it under the
#  terms of the GNU General Public License as published by the Free Software
#  Foundation; either version 2 of the License, or (at your option) any later
#  version.
#
#  dotLRN is distributed in the hope that it will be useful, but WITHOUT ANY
#  WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
#  FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more
#  details.
#

ad_library {
    Procs to manage dotLRN Applets

    @author ben@openforce.net
    @creation-date 2001-10-01
}

namespace eval dotlrn_applet {

    ad_proc -public get_url {
    } {
        Get base applets URL.
    } {
        # MAJOR FIXME NOW
        return "[dotlrn::get_url]/applets"
    }

    ad_proc -public get_applet_url {
        {-applet_key:required}
    } {
        Get applet url.
    } {
        set applets_node_id [site_node::get_node_id -url [get_url]]
        return [site_node::get_children -package_key $applet_key -node_id $applets_node_id]
    }

    ad_proc -public is_initialized {
    } {
        Return whether a site node exists under our applets url.
    } {
        return [site_node::exists_p -url "[get_url]/"]
    }

    ad_proc -public init {
    } {
        Create a new site note for our applets under the dotLRN one.
    } {
        site_node::new -name applets -parent_id [dotlrn::get_node_id]
    }

    ad_proc -public applet_exists_p {
        {-applet_key:required}
    } {
        Check whether "applet_key" is a real dotLRN applet.
    } {
        return [db_string select_applet_exists_p {}]
    }

    ad_proc -public add_applet_to_dotlrn {
        {-applet_key:required}
        {-package_key:required}
        {-active_p t}
    } {
        dotlrn-init.tcl calls AddApplet on all applets using acs_sc directly.
        The add_applet proc in the applet (e.g. dotlrn-calendar) calls this
        proc to tell dotlrn to register and/or activate itself. This _must_
        be able to be run multiple times!
    } {
        if {[get_applet_id_from_key -applet_key $applet_key] ne ""} {
            return
        }

        set applet_id [db_nextval acs_object_id_seq]
        db_dml insert {}
    }

    ad_proc -public get_applet_id_from_key {
        {-applet_key:required}
    } {
        Get the id of the dotlrn applet from the applet key or the null
        string if the key does not exist.
    } {
        return [db_string select {} -default ""]
    }

    ad_proc -public mount {
        {-package_key:required}
        {-url ""}
        {-pretty_name ""}
    } {
        Mount a package under applets site node.
    } {
        if {$url eq ""} {
            set url $package_key
        }

        set parent_node_id [site_node::get_node_id -url [get_url]]

        set package_id [dotlrn::mount_package \
            -parent_node_id $parent_node_id \
            -package_key $package_key \
            -url $url \
            -directory_p t \
            -pretty_name $pretty_name \
        ]

        return $package_id
    }

    ad_proc -public get_applet_url {
        {applet_key:required}
    } {
        Get the applet's URL (empty).
    } {
    }

    ad_proc -public list_applets {} {
        List the applet_keys for all dotlrn applets.
    } {
        ::dotlrn::dotlrn_cache eval applets_list {
            dotlrn_applet::list_applets_not_cached
        }                
    }

    ad_proc -private list_applets_not_cached {} {
        List the applet_keys for all dotlrn applets.
    } {
        return [db_list select_dotlrn_applets {}]
    }

    ad_proc -public is_applet_mounted {
        {-applet_key:required}
    } {
        Is the applet specified mounted.
    } {
        return [expr { [llength [site_node::get_package_url -package_key [get_package_key -applet_key $applet_key]]] > 0 }]
    }

    ad_proc -public list_mounted_applets {} {
        List all applets that are mounted.
    } {
        set applets [list]

        foreach applet [list_applets] {
            if {[is_applet_mounted -applet_key $applet]} {
                lappend applets $applet
            }
        }

        return $applets
    }

    ad_proc -public get_package_key {
        {-applet_key:required}
    } {
        Get the package key associated with the given applet.
    } {
        ::dotlrn::dotlrn_cache eval applet-package_key-$applet_key {
            dotlrn_applet::get_package_key_not_cached -applet_key $applet_key
        }  
    }

    ad_proc -private get_package_key_not_cached {
        {-applet_key:required}
    } {
        Get the package key associated with the given applet.
    } {
        return [db_string select_package_key_from_applet_key {} -default ""]
    }

    ad_proc -public dispatch {
        {-op:required}
        {-list_args {}}
    } {
        Dispatch an operation with its arguments on every dotLRN applet.
    } {
        foreach applet [list_applets] {
            applet_call $applet $op $list_args
        }
    }

    ad_proc -public applet_call {
        applet_key
        op
        {list_args {}}
    } {
        Call a particular applet op.
    } {
        acs_sc::invoke -contract dotlrn_applet -operation $op -call_args $list_args -impl $applet_key
    }

    ad_proc -public remove_applet_from_dotlrn {
        {-applet_key:required}
    } {
        Remove applet.

        @param applet_key Applet key
    } {
        if {[get_applet_id_from_key -applet_key $applet_key] eq ""} {
            return
        }

        db_transaction {
            db_dml remove_community_applet {}
            db_dml remove_applet {}
        }
    }

}


# Local variables:
#    mode: tcl
#    tcl-indent-level: 4
#    indent-tabs-mode: nil
# End:
