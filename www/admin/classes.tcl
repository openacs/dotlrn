ad_page_contract {
    Displays dotLRN classes admin page
    
    @author Ben Adida (ben@openforce.net)
    @author yon (yon@openforce.net)
    @creation-date 2001-11-04
    @version $Id$
} -query {
} -properties {
    title:onevalue
    context_bar:onevalue
}

set title "[ad_parameter classes_pretty_plural]"
set context_bar "[ad_parameter classes_pretty_plural]"

ad_return_template
