ad_page_contract {
    create a new club - input form

    @author yon (yon@openforce.net)
    @creation-date 2001-12-03
    @version $Id$
} -query {
    {referer ""}
} -properties {
    context_bar:onevalue
}

form create add_club

element create add_club club_key \
    -label "Club Key (a short name, no spaces)" -datatype text -widget text -html {size 50}

element create add_club name \
    -label "Name" -datatype text -widget text -html {size 50}

element create add_club description \
    -label "Charter" -datatype text -widget textarea -html {rows 5 cols 60 wrap soft}

element create add_club join_policy \
    -label "Join Policy" -datatype text -widget select -options {{Open open} {"Needs Approval" "needs approval"} {Closed closed}}

element create add_club referer \
    -label "Referer" -value $referer -datatype text -widget hidden

if {[form is_valid add_club]} {
    form get_values add_club club_key name description join_policy referer

    set key [dotlrn_club::new -description $description -key $club_key -pretty_name $name -join_policy $join_policy]

    if {[empty_string_p $referer]} {
        set referer "clubs"
    }

    ad_returnredirect $referer
    ad_script_abort
}

set context_bar {{clubs Clubs} New}

ad_return_template
