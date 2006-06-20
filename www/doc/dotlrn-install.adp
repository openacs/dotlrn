<master src="master">
<property name="title">Installing dotLRN - OpenForce</property>

<div class="indent">

    <h2>Installing dotLRN</h2>

    <p class="indent">part of <a href="../">dotLRN</a></p>

    <p class="indent"><small>Last updated: $Date$</small>

    <p class="heading">Contents</p>

    <ul>
        <li>Read the dotLRN FAQ
        <li>Get and Install OpenACS from development CVS
        <li>Get dotLRN from CVS
        <li>Install dotLRN on your system
        <li>Explore dotLRN
        <li>Reinstalling dotLRN
    </ul>


    <p class="heading">Read the <a href="/faq">dotLRN FAQs</a></p>

    <p class="heading">Get and Install OpenACS from development CVS</p>

    <p class="note">
       If you have a working OpenACS installation from the latest
       development CVS, make sure that you have all the packages required
       below then skip to the next section.
    </p>

    <p class="indent">
       
       If you are installing OpenACS, follow the extensive
       installation <a
       href="http://openacs.org/doc/openacs-4">documentation</a>.
       <strong>Stop</strong> at the <a
       href="http://openacs.org/doc/openacs-4/openacs.html">point</a>
       where the OpenACS installation instructions tell you to
       &quot;download OpenACS&quot;. Don't use the &quot;Quick
       Downloads&quot;! Continue on with this document.

    <p class="indent">

      <pre>      
      cvs -d :pserver:anonymous@cvs.openacs.org:/cvsroot login
      (just hit return for the password)
      cvs -z3 -d :pserver:anonymous@cvs.openacs.org:/cvsroot checkout acs-core
      </pre>
      
    <p class="note">
      CVS commandlines are given in terms of anonymous users, if you have an
      account on openacs.org, use your login where appropriate. Don't forget to
      set the CVS_RSH variable in your shell envrioment to &quot;ssh&quot;.

    <p class="indent">

      dotLRN requires some more modules that are not in
      <tt>acs-core</tt>, but not all of the packages in the OpenACS
      source tree. Next are the commands to get these modules.

    <p class="indent">
      Here's the current list of non-core packages needed for dotlrn:

    <p class="indent">
      <pre>
      acs-datetime
      acs-developer-support (optional)
      acs-events
      acs-mail-lite
      attachments
      bulk-mail
      calendar
      faq
      file-storage
      forums
      general-comments
      news
      notifications
      ref-timezones
      user-preferences
      </pre>      
    </p>

    <p class="note">
      <strong>Do not install</strong> or, if installed, <strong>remove</strong> these
        packages since they conflict with dotlrn packages: <tt>portal</tt>
        (conflicts with new-portal) and <tt>spam</tt>
        (conflicts with bulk-mail)
    </p>

    <p class="indent">
      <tt>cd</tt> to the newly created <tt>/openacs-4/packages</tt>
      directory before the next command.

    <p class="indent">
      <pre> 
      cvs -z3 -d :pserver:anonymous@cvs.openacs.org:/cvsroot co \
      acs-datetime acs-developer-support acs-events acs-mail-lite \
      attachments bulk-mail calendar faq file-storage forums general-comments \
      news notifications ref-timezones user-preferences
      </pre>

    <p class="note">
       Installation timesaver: In the <tt>/packages/ref-timezones/sql/common/</tt>
       directory, cut down the files to a few <tt>insert</tt> statements apiece.
       This is fine for test system, and will save you a lot of time in the
       installation process.

    <p class="indent">
      You will now have an <tt>/openacs-4</tt> directory with all of
      OpenACS required by dotLRN. To double check, your
      <tt>/openacs-4/packages</tt> directory should look similar to this:

    <pre>
      $ ls
      acs-admin                acs-kernel            acs-templating  forums
      acs-api-browser          acs-mail              acs-util        general-comments
      acs-bootstrap-installer  acs-mail-lite         acs-workflow    news
      acs-content              acs-messaging         attachments     notifications
      acs-content-repository   acs-notification      bulk-mail       page
      acs-core-docs            acs-reference         calendar        ref-timezones
      acs-datetime             acs-service-contract  CVS             search
      acs-developer-support    acs-subsite           faq             skin
      acs-events               acs-tcl               file-storage    user-preferences
    </pre>

    <p class="heading">Get dotLRN from CVS</p>

    <p class="indent">
       Getting dotLRN from CVS is just like getting OpenACS from CVS
       with a different CVSROOT.

    <p class="indent">

      Change to your <tt>/openacs-4/packages</tt> directory issue the
      following commands:
       
      <pre>
      cvs -d :pserver:anonymous@dotlrn.openforce.net:/dotlrn-cvsroot login
      (hit return for prompted for password)
      cvs -z3 -d :pserver:anonymous@dotlrn.openforce.net:/dotlrn-cvsroot co dotlrn-core       
      </pre>

    <p class="indent">
      This will fetch the following packages to your
      <tt>/openacs-4/packages</tt> directory<BR>
      <font color=red>(Updated August 29: removed research-portlet and dotlrn-research)</font>:

    <p class="indent">

      <pre>
        dotlrn
        dotlrn-syllabus
        new-portal
        profile-provider
        user-profile
        bm-portlet 
        dotlrn-bm
        calendar-portlet
        dotlrn-calendar
        dotlrn-portlet
        dotlrn-dotlrn
        faq-portlet
        dotlrn-faq
        forums-portlet
        dotlrn-forums
        fs-portlet
        dotlrn-fs
        news-portlet
        dotlrn-news
        static-portlet
        dotlrn-static
      </pre>

    <p class="indent">

      A few minor
      modifications of the OpenACS code needs to be done here. First,
      in the <tt>/openacs-4</tt> directory (where you see the <tt>bin,
      CVS, packages ...</tt> directories), make sure a directory named
      <tt>content-repository-content-files</tt> exists. If not, create
      it with the same permissions as the other dirs.

    <p class="indent">
      Next, copy the <tt>/openacs-4</tt> directory to where ever you
      prefer your webserver root to be, traditionally
      <tt>/web</tt>. Now you can continue with the OACS <a
      href="http://openacs.org/doc/openacs-4/openacs.html">installation
      document</a> at the third bullet point. Continue with the
      standard OACS installation process until your reach the
      &quot;Congratulations!&quot; front page, then return here.

  <p class="heading">Install dotLRN on your system</p>
  <p class="indent">

     Go the the &quot;ACS Package Manager&quot; (APM) on your system
     at <tt>http://yourserver/acs-admin/apm</tt> and hit the
     &quot;Install packages&quot; link. After the installer loads, you
     will see a list of the packages you just got from CVS. Click the
     button at the bottom of the page to Install them. You do not
     have to restart your server at ths point.
  </p>

  <p class="indent">
  
     Next go to the &quot;Site Map&quot; on your system at
     <tt>http://yourserver/admin/site-map</tt>. Click the &quot;new
     sub folder&quot; link to the right of the &quot;Main Site&quot;
     link at the top of the table. Enter <tt>dotlrn</tt> in the
     textbox, and hit the button.
  
  </p>     

  <p class="indent">
     
     There will be a new entry in the URL column for
     &quot;dotlrn&quot; with &quot;(none)&quot; in the application
     column, to the right of this, click the &quot;New
     Application&quot; link.  Enter <tt>dotlrn</tt> into the textbox
     and select &quot;dotLRN&quot; from the drop-down list and hit the
     button.
  
  </p>   
  
  <p class="indent">

     There will now be &quot;dotlrn&quot; in the application column to
     the right of the &quot;dotlrn/&quot; URL.
  
  </p>

  <p class="indent">

     Install the
     &quot;notifications&quot; and &quot;attachments&quot; packages at
     the URL &quot;/notifications&quot; and
     &quot;/attachments&quot;the same way you installed
     &quot;dotlrn&quot;
     
  </p>

  <!-- Add note about developer-support here -->
  
  <p class="indent">

     Next you must set some parameters from the <tt>Site Map</tt>
     page. 

     <ul>
     
     For the &quot;Main
     site&quot; (the first row of the table at
     the top of the page), set the &quot;DefaultMaster&quot; parameter
     from <tt>/www/default-master</tt> to
     <tt>/packages/dotlrn/www/dotlrn-master</tt>.

     <li>For the <tt>ACS Kernel</tt> (the first item in the list below
     the table) in the <tt>system-information</tt> section, set the
     <tt>CommunityMemberURL</tt> from <tt>/shared/community-member</tt> to
     <tt>/dotlrn/community-member</tt>

     <li>In the same <tt>system-information</tt> section, set the
     <tt>CommunityMemberAdminURL</tt> from <tt>/acs-admin/users/one</tt> to
     <tt>/dotlrn/admin/user</tt>

     </ul>
  </p>

  <p class="indent">
  
     <b>You must now restart your server, wait a few minutes, and
     reload the &quot;Site Map&quot; page in your browser</b> After
     the server restarts, refresh the &quot;Site Map&quot;. You will
     see a &quot;(+)&quot; to the left of the dotlrn/ URL and a new
     URL: &quot;portal/&quot; with application &quot;new-portal&quot;.

  </p>

  <p class="note">

     Aren't seeing the &quot(+)&quot; beside <tt>dotlrn/</tt>?
     Something went wrong. Did you restart your server? Restart again
     while doing a <tt>tail -f</tt> of the error log with debug turned
     on in your AOLServer configuration. Please report all errors you
     encounter to <a href="/bugs">the Bug Tracker</a>.
  </p>

  <!-- TODO: re-vamp this section -->

  <p class="heading">Explore dotLRN</p>

  <p class="indent">

      Go to dotLRN Administration at
      <tt>http://yourserver/dotlrn/admin</tt>.  Make some dotLRN
      users, terms, departments, classes. 
  
  </p>

  <p class="indent">

      Here are some suggestions for things to check out in dotlrn:

  </p>

  <p class="indent">
  
      Goto /dotlrn your "workspace". Click the "Control Panel" link at
      the top and try the "Customize this portal" link there.  Goto
      the admin pages for a class or community and try the "Manage
      Membership" link. Create a new sugroup for a class or community. 
      Edit or create new "Custom Portlets". 

  </p>

      
  <p class="indent">

     Enjoy!

  </p>

  <p class="heading">Automatated Installation</p>

  <p class="indent">


  <font color=red>(new Oct 11)</font>
  As an alternative to the manual installation above. Peter Marklund
  (peter_marklund@fastmail.fm) has developed scripts to automate installation.
  If you are just starting out with dotlrn, it would be a good idea to 
  go through the manual installation a few times before trying to use
  the automated scripts.
    
  To get the scripts, use the following commandline:

  <pre>cvs -d :pserver:anonymous:@dotlrn.collaboraid.biz:/cvsroot checkout dotlrn-install</pre>

  </p>


  <p class="heading">Manual Re-installation</p>

  <p class="indent">
     
     Sometimes you have to dump your DB. Here's the dotLRN reinstall
     process.

    <p class="indent">
        <strong>Important note:</strong>If you have the dotlrn-survey,
        and/or survey-portlet directories on your system, please delete them as
        they are no longer part of the <tt>dotlrn-core</tt> packages. If you    
        are not using simple-survey aside from dotlrn, you can delete that too.

     <ol>
       <li>Stop <tt>aolserver</tt> and any open <tt>sqlplus</tt>
       sessions <li>Create a drop/create user script. Lars has a swift
       <a href="http://pinds.com/acs-tips/oracle-statements">tool</a>
       to help you create one.  <li>In a shell, type:
         <pre class="code">
           % sqlplus internal < my-drop-create-script.sql
         </pre>
        
          Verify that your database user was droped and created
          successfully.  If you get an error saying: <tt>Cannot drop a
          user that is currently connected</tt>, close all open
          <tt>sqlplus</tt> sessions and repeat the command above.
       <li>Now would be a good time to <tt>cvs update</tt> OpenACS and dotLRN
       <li>Re-start <tt>aolserver</tt>, wait 20 seconds or so, and
           do the standard OpenACS installation.
       <li>Go to the <strong>Install dotLRN on your system</strong>
           section of this document and continue from there.

</div>
