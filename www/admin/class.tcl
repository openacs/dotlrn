ad_page_contract {
    Displays single dotLRN class page

    @author Ben Adida (ben@openforce.net)
    @author yon (yon@openforce.net)
    @creation-date 2001-11-07
    @version $Id$
} -query {
    class_key:notnull
    {term_id -1}
} -properties {
    pretty_name:onevalue
    description:onevalue
    class_instances:multirow
    can_instantiate:onevalue
}

# Get information about that class
if {![db_0or1row select_class_info {}]} {
    ad_returnredirect "classes"
    ad_script_abort
}

set terms [db_list_of_lists select_terms_for_select_widget {
    select dotlrn_terms.term_name || ' ' || dotlrn_terms.term_year,
           dotlrn_terms.term_id
    from dotlrn_terms
    where dotlrn_terms.end_date > (sysdate - 360)
    and dotlrn_terms.start_date < (sysdate + 360)
    order by dotlrn_terms.start_date,
             dotlrn_terms.end_date
}]
set terms [linsert $terms 0 {All -1}]

form create term_form

element create term_form term_id \
    -label "Term" \
    -datatype integer \
    -widget select \
    -options $terms \
    -html {onChange document.term_form.submit()} \
    -value $term_id

element create term_form class_key \
    -label "Class Key" \
    -datatype text \
    -widget hidden \
    -value $class_key

if {[form is_valid term_form]} {
    form get_values term_form term_id class_key
}

set query "select_class_instances"
if {$term_id == -1} {
    set query "select_all_class_instances"
}

db_multirow class_instances $query {}

set can_instantiate [dotlrn_class::can_instantiate -class_key $class_key]

set context_bar [list [list classes [ad_parameter classes_pretty_plural]] One]

ad_return_template
