
#
# Procs for DOTLRN user extension
# Copyright 2002 OpenForce, inc.
# Distributed under the GNU GPL v2
#
# Jan 22, 2002
#

ad_library {

    Procs for dotLRN user extension

    @author ben@openforce.net
    @creation-date 2002-01-22

}

namespace eval dotlrn_user_extension {

    ad_proc -public automatic_email_patterns {} {
        Returns a list of email patterns for which a user is automatically made into a dotLRN user
    } {
        set param [ad_parameter -package_id [dotlrn::get_package_id] auto_dotlrn_user_email_patterns]

        return [split $param ","]
    }

    ad_proc -public user_new {
        user_id
    } {
        A new user has been added: process dotLRN specific stuff
    } {
        # Get the user's email address
        set email [cc_email_from_party $user_id]

        # Loop through patterns
        foreach pattern [automatic_email_patterns] {
            ns_log Notice "DOTLRN: checking if $email matches $pattern"
            if {[string match $pattern $email]} {
                ns_log Notice "DOTLRN: YES IT DOES!"
                # create the dotLRN user now
                dotlrn::user_add -rel_type dotlrn_full_user_rel -user_id $user_id

                break
            }
        }
    }

    ad_proc -public user_approve {
        user_id
    } {
        A user has been approved: process dotLRN specific stuff
    } {

    }

    ad_proc -public user_deapprove {
        user_id
    } {
        A user has been deapproved
    } {

    }

    ad_proc -public user_modify {
        user_id
    } {
        A user has been modified
    } {

    }

    ad_proc -public user_delete {
        user_id
    } {
        A user is being deleted
    } {

    }

}
