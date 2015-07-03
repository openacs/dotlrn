<master src="master">
<property name="doc(title)">dotLRN Architecture</property>
<h2>dotLRN Architecture</h2>
by <a href="mailto:ben@openforce.net">Ben Adida</a> and <a href="arjun@openforce.net">Arjun Sanyal</a>, part of <a href="./">dotLRN Documentation</a>.
<hr><p>


dotLRN is built on OpenACS 4.x, a modular architecture for
community-oriented web applications. dotLRN is also
<strong>modular</strong> in that new course management functionality
can be added as desired. Since dotLRN modules must function within the
dotLRN architecture, dotLRN modularity must be built on top of OpenACS
modularity.

<p>

The dotLRN architecture attempts to define a framework within which
learning communities develop. A learning community may take many
different forms but remains the crux of the architecture.


<h2>dotLRN Community</h2>

A <strong>dotLRN Community</strong> is architected as a series of
OpenACS components, with a heavy use of the <strong>subsite</strong>
concept. One community is represented by:

<ul>
<li> <strong>an OpenACS group</strong>: this serves to define membership
and roles within the learning community.
<li> <strong>a site node</strong>: this serves to define a
consistent URL for the learning community, and to segment away each
communities from one another. An example is <tt>/dotlrn/alumni-1998</tt>.
<li> <strong>an instance of the dotLRN Community Manager
package</strong>: this serves to display community-specific data
in a way that is clearly segmented away from the other learning
communities using the <i>acs-subsite</i> constructs.
</ul>

<h3>OpenACS Group</h3>

The core dotLRN group type is <tt>dotlrn_community</tt>. This group
type defines some basic attributes that all communities have:
<ul>
<li> <b>a short name</b>: a simple name with no spaces, no special
characters, usually all lowercase. e.g. finance-101
<li> <b>a pretty name</b>: a name that is used in pretty
presentation. e.g. Finance 101
<li> <b>start and end dates</b>: for communities that have certain
validity periods, a start date and end date.
</ul>

There are two different types of learning communities in the basic
dotLRN release: <strong>class instances</strong> and
<strong>clubs</strong>. While Clubs need no additional attributes,
Class Instances require information concerning the Term and Year of
the Class Instance.

<h3>Site Node</h3>

In dotLRN, a community is mounted only at one particular node. In the
future, if communities end up being multi-mounted, there will have to
remain a canonical location for the community in order to ensure
maximal modularity - specifically the ability to point to a
community's URL using only the <tt>community_id</tt> as a starting
point.

<h3>Instance of dotLRN Community Manager</h3>

The core dotLRN OpenACS package is called <tt>dotlrn</tt>
(surprisingly enough). This package is meant to be remounted to handle
community types and specific communities. A <tt>package_id</tt>
corresponds to each community.

<p>

The group types for these two dotLRN Community Types are
<tt>dotlrn_class_instance</tt> and <tt>dotlrn_club</tt>.

<h2>Use of NPA</h2>

dotLRN makes heavy use of the <b>New Portal Architecture</b>.

<p>

Each full-access user has a personal portal where all data from all
communities is centralized in one place. This is called the <b>dotLRN
User Portal</b>.

<p>

Each community has a non-member portal which displays information
to those browsing the system and wanting to find out more about a
community before joining it. This is called the <b>dotLRN Community
Non-Member Portal</b>.

<p>

Each community also has an administrative portal which centralizes all
administrative functionality for that community. This is called the
<b>dotLRN Community Admin Portal</b>.

<p>

Finally, each community member has her own <b>dotlrn Community Member
Portal</b>. The important distinction here is that there is a
different portal for each member of this community. Thus, if a
community has 100 members, there are 100 individually managed
portals. These portals are initially created from the <b>dotLRN
Community Portal Template</b> that administrators of the community control.

<h2>dotLRN Applets</h2>

dotLRN Communities have various packages of functionality. These
packages (<b>dotLRN applets</b>) are much like existing OpenACS 4
packages, but with added specifications, special callback interfaces,
and predictable APIs that not every OpenACS 4 package will have.

<p>

Thus, a <strong>dotLRN Applet</strong> is composed of <b>three</b>
pieces that may each be a separate OpenACS package:

<ul>
<li> <b>OpenACS raw functionality</b>, to provide discussion
forum functionality. As much as possible, this shouldn't depend on
other dotLRN components. (e.g. bboard)

<li> <b>OpenACS portlet</b>, using the New Portal Architecture (NPA),
to provide the ability to display the raw functionality in a portal
interface. This obviously depends on the the NPA, but should otherwise
be as independent as possible from dotLRN. (e.g. bboard-portlet)

<li> <b>dotLRN functionality hooks</b>, to link the raw functionality
into the appropriate dotLRN structure. This obviously depends on
dotLRN, but should be as thin a layer as possible on top of the the
previous two components. (e.g. dotlrn-bboard).
</ul>

<p>

<h3>NPA Interactions</h3>

The relationship between the NPA and the portlet functionality is
explored in the <a href="npa-architecture.adp">NPA Architecture Manual</a>.

<p>

<h3>dotLRN Applet API</h3>

The relationship between dotLRN and the specific dotLRN-dependent
packages (dotlrn-bboard, dotlrn-faq, etc...) is defined using
<b>ACS Service Contract</b>. ACS Service Contract defines a standard
provider/consumer interface with special contract APIs. The dotLRN
system defines the <b>dotLRN Applet Contract</b>, which includes the
following operations:
<ul>
<li> <b>GetPrettyName</b>: Obtain a pretty, presentable name for the
applet in question.
<li> <b>AddAppletToCommunity</b>: Add the applet to a
new community. This will most probably entail instantiating a new package for
this functionality, mounted below the community's main mount point. It
will also involve setting up applet-specific data structures (e.g. a
new forum inside bboard).
<li> <b>RemoveAppletFromCommunity</b>: Remove the applet from the
community. This will entail cleaning up any applet-specific data
structures, removing the mount point and package instance.
<li> <b>AddUser</b>: add a user to dotLRN in general. This user has
not yet joined any community, but may need user-specific functionality
enabled (a private folder for files, a personal calendar, etc..)
<li> <b>RemoveUser</b>: remove a user from dotLRN in general. This
cleans up the AddUser operation.
<li> <b>AddUserToCommunity</b>: add a user to the community, and perform any
applet-specific related actions. For applets that are represented via
a portlet (which is often, but not always, the case), this will add
the right portlet to the user's portal page for that community. It
will also add the generic portlet to the user's main, cross-community
workspace.
<li> <b>RemoveUserFromCommunity</b>: remove a user from a community,
and thus clean up the actions of AddUserToCommunity.
</ul>

<p>

The specifics of creating a dotLRN package are described in the <a
href="writing-a-dotlrn-package.adp">dotLRN Package Creation Guide</a>.
