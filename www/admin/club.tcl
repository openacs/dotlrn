ad_page_contract {
    displays dotLRN clubs admin page

    @author yon (yon@openforce.net)
    @creation-date 2001-12-03
    @version $Id$
} -query {
} -properties {
    club_id:onevalue
    pretty_name:onevalue
    descrition:onevalue
    url:onevalue
}

if {![exists_and_not_null url]} {
    db_1row select_club {}
}

ad_return_template
