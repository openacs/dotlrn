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

    Procs for dotLRN user extension

    @author ben@openforce.net
    @creation-date 2002-01-22

}

namespace eval dotlrn_user_extension {

    ad_proc -public automatic_email_patterns {} {
        Returns a list of email patterns for which a user is automatically made into a dotLRN user
    } {
        set param [parameter::get -package_id [dotlrn::get_package_id] -parameter auto_dotlrn_user_email_patterns]

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
            if {[string match $pattern $email]} {
                # create the dotLRN user now
                dotlrn::user_add -type student -can_browse_p -user_id $user_id
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
