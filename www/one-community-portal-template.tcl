# /dotlrn/www/one-community-portal-template.tcl
ad_page_contract {
    Configuration page for an instance's portal template

    @author Arjun Sanyal (arjun@openforce.net)
    @version $Id$
} -query {
    {referer "one-community-admin"}
}

set portal_id [dotlrn_community::get_portal_template_id]

set rendered_page [portal::template_configure $portal_id $referer]

ad_return_template
