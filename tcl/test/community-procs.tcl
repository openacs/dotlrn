ad_library {

    Automated tests for security hole found on cloned communities

    @author Roel Canicula (roel@solutiongrove.com)
    @creation-date 2006-02-08
    @cvs-id $Id$
}

aa_register_case -cats { api } \
    -procs { dotlrn_community::new dotlrn_community::clone } \
    dotlrn_community_clone { Test permission settings of cloned community } {
	aa_run_with_teardown \
	    -rollback \
	    -test_code {
		set community_name [ad_generate_random_string 8]
		set community_id [dotlrn_community::new \
				      -pretty_name $community_name \
				      -community_type "dotlrn_club"]
		aa_log "created community: $community_name, $community_id"
		aa_false "community_inherits_permissions" [permission::inherit_p \
							      -object_id $community_id]

		set clone_id [dotlrn_community::clone \
				  -community_id $community_id \
				  -key [ad_generate_random_string 8]]
		aa_log "cloned community: $clone_id"
		aa_false "cloned_community_inherits_permissions" [permission::inherit_p \
								      -object_id $clone_id]
	    }
    }

aa_register_case -cats { db security_risk } \
    -procs { } \
    communities_security_inherit {
        Test permission settings of all communities
    } {
        aa_false "Communities do not inherit permissions (high probability of security risk)" [db_string get_communities_with_inherit {
            select exists (select 1
                           from dotlrn_communities_all c, acs_objects o
                           where c.community_id = o.object_id
                           and o.security_inherit_p = 't')
            from dual
        }]
    }

# Local variables:
#    mode: tcl
#    tcl-indent-level: 4
#    indent-tabs-mode: nil
# End:
