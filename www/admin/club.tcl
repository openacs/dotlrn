# dotlrn/www/admin/club.tcl

ad_page_contract {
    displays single dotLRN club page

    @author yon (yon@openforce.net)
    @creation-date 2001-12-03
    @version $Id$
} -query {
    club_id:naturalnum,notnull
} -errors {
    club_id:naturalnum,notnull {must provide a valid club_id}
} -properties {
    context_bar:onevalue
    pretty_name:onevalue
    description:onevalue
}

db_1row select_club {}

set context_bar [list [list clubs [ad_parameter clubs_pretty_plural]] $pretty_name]

ad_return_template
