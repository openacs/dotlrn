#if { [ad_ssl_available_p] } {
#    ad_register_filter preauth GET "[dotlrn::get_url]/admin/*" ad_restrict_to_https
#}