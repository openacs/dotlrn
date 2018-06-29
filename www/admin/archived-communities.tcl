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

ad_page_contract {
    displays archived communities

    @author arjun (arjun@openforce.net)
    @cvs-id $Id$
} -query {
} -properties {
    title:onevalue
    context_bar:onevalue
    archived_comms:multirow
}

#Pages in this directory are only runnable by dotlrn-wide admins.
dotlrn::require_admin 

set groups_pretty_plural "[parameter::get -localize -parameter class_instances_pretty_plural] / [parameter::get -localize -parameter clubs_pretty_plural]"

set title [_ dotlrn.archived_groups]
set context_bar [list $title]

# AEG: This query has gotten pretty nasty.  Basically we need to
# provide the site-wide admin more information about communities than
# just the name.  Time information is key, so we try to associate
# classes with a term.  If the community is not a class, we look to
# see if the parent is a class.  We don't do the full recursion for
# sub-subgroups etc.  We could push that into some expensive plsql if
# the current version turns out to be too hackish.  Or maybe creation
# date is all we need, and we can throw the rest out?
db_multirow -extend {
    unarchive_url
    url
    parent_url
} archived_comms select_archived_comms {
            select child.community_id,
                   child.pretty_name, 
                   child.description,
                   parent.community_id as parent_community_id,
                   parent.pretty_name as parent_pretty_name,
                   parent.community_id as parent_community_id,
                   class.term_name,
                   class.term_year,
                   parent_class.term_name as parent_term_name,
                   parent_class.term_year as parent_term_year,
                   to_char(o.creation_date, 'Mon YYYY') as creation_date,
                   to_char(o.last_modified, 'Mon YYYY') as last_modified
            from dotlrn_communities_all child left outer join
                 dotlrn_communities_all parent using (community_id),
                 dotlrn_communities_all child1 left outer join
                 (select i.class_instance_id,
                         t.term_name,
                         t.term_year
                  from dotlrn_class_instances i,
                       dotlrn_terms t
                  where t.term_id = i.term_id) class on child1.community_id = class.class_instance_id,
                 dotlrn_communities_all child2 left outer join
                 (select i.class_instance_id,
                         t.term_name,
                         t.term_year
                  from dotlrn_class_instances i,
                       dotlrn_terms t
                  where t.term_id = i.term_id) parent_class on child2.community_id = parent_class.class_instance_id,
                  acs_objects o
            where child.archived_p = 't' 
              and child1.archived_p = 't' and child2.archived_p = 't'
              and child1.community_id = child.community_id
              and child2.community_id = child.community_id
              and o.object_id = child.community_id
            order by child.pretty_name    
} {
    set url [dotlrn_community::get_community_url $community_id]
    set parent_url [expr {$parent_community_id ne "" ? \
                              [dotlrn_community::get_community_url $parent_community_id] : ""}]
    set description [ns_quotehtml $description]
    set unarchive_url "unarchive?community_id=$community_id"
}

# Local variables:
#    mode: tcl
#    tcl-indent-level: 4
#    indent-tabs-mode: nil
# End:
