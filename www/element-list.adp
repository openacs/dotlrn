<master>
<property name="title">Portlet Names</property>
<property name="context">"Portlet Names"</property>

<p></p>

<center>
<table class="list" cellpadding="3" cellspacing="1">
     <tr class="list-header" >
       <td class="list">ID</td>
       <td class="list">Type</td>
       <td class="list">Name</td>
       <td class="list">Page</td>
     
     </tr> 
  <multiple name=portal_elements>
    
     <tr>
         <td class="list"><a href=element-rename?element_id=@portal_elements.element_id@>@portal_elements.element_id@</a></td>
         <td class="list">@portal_elements.name@</td>
	 <td class="list">@portal_elements.pretty_name@</td>
	 <td class="list">@portal_elements.sort_key@</td>
	
     </tr>
  </multiple>
</table>
</center>



<p> 

    
    
   
