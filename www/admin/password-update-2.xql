<?xml version="1.0"?>

<queryset>

    <fullquery name="select_user_email">
        <querytext>
    	  select email	
           from registered_users
           where user_id = :user_id
        </querytext>
    </fullquery>

</queryset>
