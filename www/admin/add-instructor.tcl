# dotlrn/www/admin/add-instructor.tcl

ad_page_contract {
    @author yon (yon@milliped.com)
    @creation-date Jan 10, 2002
    @version $Id$
} -query {
    community_id:integer,notnull
    {referer "./"}
}

set context_bar {{Add a Professor}}

ad_return_template
