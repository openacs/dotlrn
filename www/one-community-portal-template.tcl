# /dotlrn/www/one-community-portal-template.tcl
ad_page_contract {
    Configuration page for an instance's portal template

    @author Arjun Sanyal (arjun@openforce.net)
    @cvs-id $Id$
} {
    portal_id:naturalnum,notnull
    return_url:notnull
}

set rendered_page [portal::template_configure $portal_id $return_url]

ad_return_template
