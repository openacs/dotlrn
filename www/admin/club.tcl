ad_page_contract {
    displays single dotLRN club page
    
    @author yon (yon@openforce.net)
    @creation-date 2001-12-03
    @cvs-id $Id$
} -query {
    club_id:naturalnum,notnull
} -errors {
    club_id:naturalnum,notnull {must provide a valid club_id}
} -properties {
    context_bar:onevalue
    pretty_name:onevalue
    description:onevalue
}

set context_bar {{clubs Clubs} One}

db_1row select_club {}

ad_return_template
