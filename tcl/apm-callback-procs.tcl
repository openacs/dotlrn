# /packages/dotlrn/tcl/apm-callback-procs.tcl

ad_library {

     dotlrn Package APM callbacks library

     Procedures that deal with installing.

     @creation-date July 2004
     @author  Hector Amado (hr_amado@galileo.edu)
     @cvs-id $Id$

}

namespace eval dotlrn {}
namespace eval dotlrn::apm {}

ad_proc -private dotlrn::apm::after_install {
} {
  Create the new group, dotlrn-admin
} {

  # Create a new group, dotlrn-admin
    db_transaction {
        set group_id [group::new -group_name "dotlrn-admin" ] 
    }

    #gran new-portal admin permission
    permission::grant \
	    -party_id $group_id \
	    -object_id [apm_package_id_from_key new-portal] \
	    -privilege "admin"

    parameter::set_from_package_key \
        -package_key acs-kernel \
        -parameter HomeURL \
        -value /dotlrn/control-panel
}


ad_proc -private dotlrn::apm::after_instantiate {
     -package_id:required
} {
      grant permission, dotlrn-admin
} {

       set group_id [db_string group_id_from_name "
            select group_id from groups where group_name='dotlrn-admin'" -default ""]
        if {![empty_string_p $group_id] } {
   
        #Admin privs
        permission::grant \
            -party_id $group_id \
            -object_id $package_id  \
            -privilege "admin"

        }
       # Get the default Site Template
       set default_template_name [parameter::get \
                                     -package_id $package_id \
                                     -parameter DefaultSiteTemplate]
       set site_template_id [db_string select_st_id {}]
       
       # for communities
       parameter::set_value -package_id $package_id \
	   -parameter  "CommDefaultSiteTemplate_p" \
	   -value $site_template_id
	   
       # for users
       parameter::set_value -package_id $package_id \
	   -parameter  "UserDefaultSiteTemplate_p" \
	   -value $site_template_id

       # Make sure that privacy is turned on
       acs_privacy::privacy_control_set 1
	
}



ad_proc -private dotlrn::apm::before_uninstall {
} {
  Drop the group, dotlrn-admin
} {

      set group_id [db_string group_id_from_name "
            select group_id from groups where group_name='dotlrn-admin'" -default ""]
      if {![empty_string_p $group_id] } {

           permission::revoke \
                 -party_id $group_id \
                 -object_id [dotlrn::get_package_id]  \
                 -privilege "admin"

           # Drop the group, dotlrn-admin
           db_transaction {
    	         set object_id [group::delete $group_id]
           }
      } 

}


ad_proc -public dotlrn::apm::after_upgrade {
    {-from_version_name:required}
    {-to_version_name:required}
} {
     apm_upgrade_logic \
        -from_version_name $from_version_name \
        -to_version_name $to_version_name \
	-spec {  
	    2.0.3 2.1.0 {     
                db_transaction {

                        ns_log notice "dotlrn upgrade: starting..."
                        #create dotlrn-admin group
                        set dotlrn_admins_group [group::new  -group_name "dotlrn-admin" ] 
                        ns_log notice "dotlrn upgrade: dotlrn-admin group created..."
                        
                        #grant dotlrn admin permission
                        permission::grant \
                             -party_id $dotlrn_admins_group \
	                     -object_id [dotlrn::get_package_id]  \
                             -privilege "admin"   

                        ns_log notice "dotlrn upgrade: dotlrn permission granted..."

                        #grant dotlrn-portlet admin permission
                        permission::grant \
                             -party_id $dotlrn_admins_group \
	                     -object_id [apm_package_id_from_key dotlrn-portlet]  \
                             -privilege "admin"

                        ns_log notice "dotlrn upgrade: dotlrn-portlet permission granted..."

                        #gran new-portal admin permission
			permission::grant \
			    -party_id $dotlrn_admins_group \
			    -object_id [apm_package_id_from_key new-portal] \
			    -privilege "admin"

			ns_log notice "dotlrn upgrade: new-portal permission granted..."

		    }
		
		db_transaction {
		    
                        #grant admin permission on old communities
                        db_foreach community_group "select community_id from dotlrn_communities" {
                        permission::grant \
                             -party_id $dotlrn_admins_group \
                             -object_id $community_id \
                             -privilege "admin"   
			
                        ns_log notice "dotlrn upgrade: community $community_id permission granted to dotlrn-admin ..."
			
		    }
		}
	    }
	    2.2.0d1 2.2.0d2 {

		#Setting the default Site Template
		set site_template_id [db_string select_st_id "select site_template_id from dotlrn_site_templates where pretty_name = '#new-portal.sloan_theme_name#'"]
		
		set package_id [dotlrn::get_package_id]
		#for communities
		parameter::set_value -package_id $package_id \
		    -parameter  "CommDefaultSiteTemplate_p" \
		    -value $site_template_id
		
		#for users
		parameter::set_value -package_id $package_id \
		    -parameter  "UserDefaultSiteTemplate_p" \
		    -value $site_template_id
		
		parameter::set_from_package_key -package_key "acs-subsite" \
		    -parameter "DefaultMaster" \
		    -value "/packages/dotlrn/www/dotlrn-master-custom"
               
               # This fixes parameter reseting from dotlrn
               set community_level_p_param_id [db_string select_clevel_id { 
                                                  select parameter_id
                                                  from apm_parameters 
                                                  where package_key='dotlrn' and
                                                  parameter_name='community_level_p'}]
               
               set comm_type_level_p_param_id [db_string select_ctlevel_id { 
                                                  select parameter_id
                                                  from apm_parameters 
                                                  where package_key='dotlrn' and
                                                  parameter_name='community_type_level_p'}]
              
              set dotlrn_level_p_param_id [db_string select_dlevel_id { 
                                                  select parameter_id
                                                  from apm_parameters 
                                                  where package_key='dotlrn' and
                                                  parameter_name='dotlrn_level_p'}]
                
               db_foreach select_attr_values {
                   select community_id from dotlrn_communities_all
                } {
                   set package_id [dotlrn_community::get_package_id $community_id] 
                   ns_log Notice "upgrade: $package_id parameter_id:
                   $community_level_p_param_id"

                   db_dml community_level_p_update { 
                    update apm_parameter_values set 
                    attr_value=(select attr_value from
                    apm_parameter_values_copy where package_id=:package_id 
                    and parameter_id=:community_level_p_param_id)
                    where package_id=:package_id and
                    parameter_id=:community_level_p_param_id
                   }
                   
                   db_dml community_type_level_p_update { 
                    update apm_parameter_values set 
                    attr_value=(select attr_value from
                    apm_parameter_values_copy where package_id=:package_id 
                    and parameter_id=:comm_type_level_p_param_id)
                    where package_id=:package_id and
                    parameter_id=:comm_type_level_p_param_id
                   }
                   
                   db_dml dotlrn_level_p_update { 
                    update apm_parameter_values set 
                    attr_value=(select attr_value from
                    apm_parameter_values_copy where package_id=:package_id 
                    and parameter_id=:dotlrn_level_p_param_id)
                    where package_id=:package_id and
                    parameter_id=:dotlrn_level_p_param_id
                   }

               }
		
	    }
	    2.2.0a2 2.2.0a3 {
		# This fixes a security hole opened up when cloning
		# communities/classes
		db_foreach get_communities_with_inherit {
		    select community_id
		    from dotlrn_communities_all c, acs_objects o
		    where c.community_id = o.object_id
		    and o.security_inherit_p = 't'
		} {
		    permission::set_not_inherit -object_id $community_id
		}		
	    
            }
	    2.2.0a3 2.2.0a4 {
                parameter::set_from_package_key \
                    -package_key acs-kernel \
                    -parameter HomeURL \
                    -value /dotlrn/control-panel
	    }
	    2.3.0d1 2.3.0d2 {     
                # Set access keys for all pages that have known titles
                set params [list]
                db_foreach get_default_values {} {
                    set params [concat $params [split [string trimright $default_value ";"] ";"]]
                }
                db_transaction {
                    foreach param $params {
                        foreach {title layout accesskey} [split $param ","] {
                            db_dml set_accesskeys {}
                        }
                    }
                }
            }
    }
}
