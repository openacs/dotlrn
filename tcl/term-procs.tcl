# dotlrn/tcl/term-procs.tcl

ad_library {
    @author yon (yon@milliped.com)
    @creation-date Dec 12, 2001
    @version $Id$
}

namespace eval dotlrn_term {
    ad_proc -public new {
        {-term_name:required}
        {-term_year:required}
        {-start_date:required}
        {-end_date:required}
    } {
        create a new term
    } {
        set start_date "[template::util::date::get_property year $start_date] [template::util::date::get_property month $start_date] [template::util::date::get_property day $start_date]"
        set end_date "[template::util::date::get_property year $end_date] [template::util::date::get_property month $end_date] [template::util::date::get_property day $end_date]"
        set date_format "YYYY MM DD"

        db_dml insert_term {}
    }

    ad_proc -public get_term_name {
        {-term_id:required}
    } {
        get the term name for this term object
    } {
        return [db_string get_term_name {}]
    }

    ad_proc -public get_term_year {
        {-term_id:required}
    } {
        get the term year for this term object
    } {
        return [db_string get_term_year {}]
    }

    ad_proc -public get_term_info {
        {-term_id:required}
        {-term_name_var "term_name"}
        {-term_year_var "term_year"}
    } {
        get the term name and year for this term object
    } {
        db_1row get_term_info {}
        upvar 1 $term_name $term_name_var $term_year $term_year_var
    }

    ad_proc -public get_start_date {
        {-term_id:required}
    } {
        get the start date of this term
    } {
        set date_format "YYYY MM DD"
        db_1row get_start_date {}

        return [template::util::date::create $year $month $day "" "" "" $date_format]
    }

    ad_proc -public get_end_date {
        {-term_id:required}
    } {
        get the end date of this term
    } {
        set date_format "YYYY MM DD"
        db_1row get_end_date {}

        return [template::util::date::create $year $month $day "" "" "" $date_format]
                    
    }
}
