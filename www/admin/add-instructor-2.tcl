# dotlrn/www/admin/add-instructor-2.tcl

ad_page_contract {
    @author yon (yon@milliped.com)
    @creation-date Jan 10, 2002
    @version $Id$
} -query {
    community_id:integer,notnull
    {search_text ""}
    {referer ""}
} -properties {
    users:multirow
}

set context_bar {Add an Instructor}

db_multirow users select_users {}

ad_return_template
