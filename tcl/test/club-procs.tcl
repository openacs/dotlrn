ad_library {

    Tests for dotlrn clubs

    @author Héctor Romojaro <hector.romojaro@gmail.com>
    @creation-date 26 February 2021
    @cvs-id $Id$
}

aa_register_case -cats {
    api
    smoke
} -procs {
    dotlrn_club::new
    dotlrn_club::community_type
    dotlrn_community::get_community_type_from_community_id
} dotlrn_club_new {
    Test creating a new dotlrn club
} {
    aa_run_with_teardown -rollback -test_code {
        #
        # Create new club
        #
        set pretty_name "My test club"
        set club_id [dotlrn_club::new -pretty_name $pretty_name]
        #
        # Check that the club exists
        #
        set club_type [dotlrn_club::community_type]
        aa_equals "Club exists" \
            [dotlrn_community::get_community_type_from_community_id $club_id] \
            "$club_type"
    }
}

# Local variables:
#    mode: tcl
#    tcl-indent-level: 4
#    indent-tabs-mode: nil
# End:
