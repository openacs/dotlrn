ad_page_contract {
    displays dotLRN clubs admin page
    
    @author yon (yon@openforce.net)
    @creation-date 2001-12-03
    @version $Id$
} {
} -properties {
    club_id:onevalue
    pretty_name:onevalue
    descrition:onevalue
}

if {![exists_and_not_null pretty_name]} {
    db_1row select_club {}
}

ad_return_template
