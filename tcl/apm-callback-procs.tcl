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
       #Setting the default Site Template
       set site_template_id [db_string select_st_id "select site_template_id from dotlrn_site_templates where pretty_name = '#new-portal.sloan_theme_name#'"]
       
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
	    2.1.3 2.2.0a1 {
		ns_log Warning "vguerra doing upgrade from 2.1.3 to 2.2.0a1"
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
		
		
	    }
	}
}
    
    

