<master src="master">
<property name="title">dotLRN FAQ</property>
<div class="indent">

    <h2>The dotLRN FAQ</h2>

    <p class="indent">part of <a href=../>dotLRN</a>

    <p class="indent"><small>Last updated: $Date$</small>

    <p class="heading">Contents
    
    <ul>
        <li><a href=dotlrn-faq.adp#basics>Basics</a>
        <li><a href=dotlrn-faq.adp#development>State of dotLRN Development</a>
        <li><a href=dotlrn-faq.adp#openforce>The OpenForce Role in dotLRN</a>
        <li><a href=dotlrn-faq.adp#openacs>dotLRN and OpenACS</a>
        <li><a href=dotlrn-faq.adp#licensing>Licensing</a>
        <li><a href=dotlrn-faq.adp#misc>Miscellaneous</a>
    </ul>

  
    <p class="heading"><a class="plain" name="basics">Basics</a>
  
    <p class="question">Q: What is dotLRN?
    <p class="answer">

        dotLRN is a full-featured application for rapidly developing
        web-based learning communities, specifically in the context of
        Course Management. The dotLRN software relies on a development
	version of <a
        href=http://openacs.org>OpenACS v4.5</a> and includes data model,
        application logic, and templates to get you up and running very
        quickly.
    
    <p class="question">Q: Is dotLRN usable?
    <p class="answer">

        dotLRN is currently in <strong>alpha</strong> state. The
        target audience at this time is mostly early
        adopters. <strong>No backwards-compatibility will be ensured
        until a beta version</strong>. That said, dotLRN is quite
        stable as is and can most certainly be used to determine
        near-term usability in a production environment.
    
    <p class="question">Q: When will dotLRN ship?
    <p class="answer">

        dotLRN beta is planned for May 1st, 2002. dotLRN v1.0 is
        planned for August 1st, 2002.
    
    <p class="question">Q: How can I contribute?
    <p class="answer">

        We are currently developing our contribution mechanisms.
        <p class="answer">If you are actively interested in helping us
        develop these mechanisms, please contact us at <a
        href=mailto:dotlrn@openforce.net>dotlrn@openforce.net</a>.
    
    <p class="question">Q: What about this dotLRN Governance discussion?
    <p class="answer">

        The discussion is still under way. MIT Sloan will be providing
        the framework for this in the very near future.


    <p class="heading"><a class="plain" name="development">State of dotLRN 
    Development</a>
  
    <p class="question">Q: So what version of OpenACS do I need to use? 
    <p class="answer">

        dotLRN will work with:
	
	<ul>
	  <li>The latest development CVS sources
	  (i.e. HEAD). Instructions to check out the latest
	  development CVS sources are on the <a
	  href="dotlrn-install.adp">dotLRN installation</a> page. 
	</ul>
	
    <p class="answer">
        dotLRN will probably work with:

	<ul>
	  <li>A recent OpenACS <a
          href="http://openacs.org/sdm/nightly-tarballs.tcl?package_id=9">nightly
          tarball</a> But we don't test this, and all the warnings on
          the page apply
	</ul>

    <p class="answer">
        dotLRN will <strong>NOT</strong> work with:

	<ul>
	  <li>The OACS v4.5 beta CVS branch
	  <li>Any OACS v4.5 beta tarballs
	</ul>

    <p class="note"> 

        When dotLRN is released as a complete tarball, we will specify
        exactly which OpenACS tarball or other package you'll
        be able to use.

    <p class="question">Q: When will dotLRN be compatible with PostgreSQL?   
    <p class="answer">

        PostgreSQL compatibility porting continues rapidly and will be
	completed in the coming weeks. A partial port is in the CVS
	tree, with more progress daily.
    
    <p class="question">Q: Can I use ACS Classic 4.2/4.3? 
    <p class="answer">
    
        Due to numerous fixes and enhancements made by the OpenACS
	developers, dotLRN will <strong>not</strong> work with ACS
	Classic. However, ACS Classic and OpenACS are similar enough
	so that code and skills based on one are very transferable
	to the other.
	    
    <p class="question">Q: Can I get a tarball of the dotLRN CVS?
    <p class="answer">
    
       Contact us at <a
       href=mailto:dotlrn@openforce.net>dotlrn@openforce.net</a> if 
       you are interested in a tarball.
       

    <p class=heading><a class=plain name=openforce> The OpenForce Role
    in dotLRN</a>
  
    <p class="question">
    Q: What's the relationship between MIT Sloan and OpenForce? 
    <p class="answer">
    
    MIT Sloan hired OpenForce to develop dotLRN to replace the aging
    SloanSpace v1, which itself was built on ACS v3.
  
    <p class="question">Q: How will OpenForce work with other OpenACS
    developers? 
    <p class="answer">

    OpenForce will continually provide anonymous CVS access to the
    dotLRN development tree. OpenForce will continue to provide
    architectural direction and goals for dotLRN. Over time, OpenForce
    will qualify and include new developers in the core development
    process. OpenForce expects to lead - but not monopolize - the dotLRN
    process. OpenForce will also provide a repository of dotLRN
    applications available for all to obtain existing dotLRN extensions
    and provide new ones to the community.
  
    <p class="question">Q: Will OpenForce develop, support, and/or host
    dotLRN commercially? 
    <p class="answer"> Absolutely.

    <p class="question">Q: Will OpenForce preclude me from providing
    my own services surrounding dotLRN? 
    <p class="answer"> Absolutely not.

    <p class="question">Q: But Why? Aren't you crazy to throw away
    such clear business opportunity? 
    <p class="answer"> 

    We are not in the business of selling packaged closed-source
    software. We believe that open-source software and a strong
    developer community provides plenty of opportunity for numerous
    commercial services. We intend to stick to the Open-Source track
    100%. No tricks here.
  

    <p class=heading><a class=plain name=openacs>dotLRN and OpenACS</a>
  
    <p class="question">Q: Is dotLRN a part of the OpenACS project? 
    <p class="answer">
    
    dotLRN is not part of the OpenACS project, but it is an OpenACS
    application. This means that dotLRN will install on a vanilla
    OpenACS without additional modifications and through the regular,
    accepted OpenACS API. While dotLRN developers happen to also be
    core OpenACS developers, the dotLRN team is taking all possible
    measures to ensure that any modification suggested to the OpenACS
    core is approved by other OpenACS developers that do not have a
    direct stake in dotLRN.
  
    <p class="question">Q: Will dotLRN be merged into OpenACS? 
    <p class="answer">
    This is a question to be answered by the OpenACS community.
  

    <p class=heading><a class=plain name=licensing>Licensing</a>

    <p class="question">Q: What are the terms of use for dotLRN? 
    <p class="answer">
    dotLRN is distributed under the GNU General Public License version 2.


    <p class=heading><a class=plain name=misc>Miscellaneous</a>
    
    <p class="question">Q: How is dotLRN spelled and pronounced?
    <p class="answer">

    It's sometimes written as <tt>.LRN</tt>, but the spelling and
    capitalization <tt>dotLRN</tt> is preferred. hackers who type a
    lot usually write <tt>dotlrn</tt>. <tt>dotLRN</tt> is pronounced
    &quot;daught-learn&quot; We are currently accepting voice
    applications for the dotLRN MP3 pronounciation file.

</div>
