ad_page_contract {
    create a new club - processing

    @author yon (yon@openforce.net)
    @creation-date 2001-12-03
    @cvs-id $Id$
} {
    key:trim
    pretty_name:trim
    description
}

set key [dotlrn_club::new -description $description -key $key -pretty_name $pretty_name]

ad_returnredirect "clubs"
