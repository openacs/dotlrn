ad_page_contract {
    Displays dotLRN departments admin page
    
    @author yon (yon@openforce.net)
    @creation-date 2002-01-20
    @version $Id$
} -query {
} -properties {
    title:onevalue
    context_bar:onevalue
    departments:multirow
}

set title "[ad_parameter departments_pretty_plural]"
set context_bar "[ad_parameter departments_pretty_plural]"

db_multirow departments select_departments {}

ad_return_template
