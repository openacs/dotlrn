ad_page_contract {
    create a new term - input form

    @author yon (yon@openforce.net)
    @creation-date 2001-12-13
    @version $Id$
} -query {
    {referer "terms"}
} -properties {
    context_bar:onevalue
}

form create add_term

element create add_term term_name \
    -label "Term (e.g. Spring, Fall)" \
    -datatype text \
    -widget text \
    -html {size 30}

element create add_term term_year \
    -label "Year" \
    -datatype text \
    -widget text \
    -html {size 5 maxsize 4}

element create add_term start_date \
    -label "Start Date" \
    -datatype date \
    -widget date \
    -format {MONTH DD YYYY}

element create add_term end_date \
    -label "End Date" \
    -datatype date \
    -widget date \
    -format {MONTH DD YYYY}

element create add_term referer \
    -label "Referer" \
    -datatype text \
    -widget hidden \
    -value $referer

if {[form is_valid add_term]} {
    form get_values add_term \
        term_name term_year start_date end_date referer

    dotlrn_term::new \
        -term_name $term_name \
        -term_year $term_year \
        -start_date $start_date \
        -end_date $end_date

    ad_returnredirect $referer
    ad_script_abort
}

set context_bar {{terms Terms} New}

ad_return_template
