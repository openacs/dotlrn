# dotlrn/www/dotlrn-main-portlet-procs.tcl

ad_page_contract {
    The display logic for the dotlrn main (Groups) portlet

    @author Arjun Sanyal (arjun@openforce.net)
    @version $Id$
}

set user_id [ad_conn user_id]

db_multirow classes select_classes {}
db_multirow clubs select_clubs {}

ad_return_template
