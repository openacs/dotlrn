ad_page_contract {
    create a new club - input form

    @author yon (yon@openforce.net)
    @creation-date 2001-12-03
    @version $Id$
} -query {
    {referer "clubs"}
} -properties {
    title:onevalue
    context_bar:onevalue
}

set title "New [ad_parameter clubs_pretty_name]"
set context_bar [list [list clubs [ad_parameter clubs_pretty_plural]] New]

form create add_club

element create add_club club_key \
    -label "[ad_parameter clubs_pretty_name] Key (a short name, no spaces)" \
    -datatype text \
    -widget text \
    -html {size 60}

element create add_club pretty_name \
    -label "Name" \
    -datatype text \
    -widget text \
    -html {size 60}

element create add_club description \
    -label "Description" \
    -datatype text \
    -widget textarea \
    -html {rows 5 cols 60 wrap soft} \
    -optional

element create add_club join_policy \
    -label "Join Policy" \
    -datatype text \
    -widget select \
    -options {{Open open} {"Needs Approval" "needs approval"} {Closed closed}}

element create add_club referer \
    -label "Referer" \
    -datatype text \
    -widget hidden \
    -value $referer

if {[form is_valid add_club]} {
    form get_values add_club \
        club_key pretty_name description join_policy referer

    set key [dotlrn_club::new \
        -description $description \
        -key $club_key \
        -pretty_name $pretty_name \
        -join_policy $join_policy]

    ad_returnredirect $referer
    ad_script_abort
}

ad_return_template
