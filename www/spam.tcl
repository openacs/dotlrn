# dotlrn/www/spam.tcl

ad_page_contract {
    @author yon (yon@milliped.com)
    @creation-date Jan 19, 2002
    @version $Id$
} -query {
    {community_id ""}
    {rel_type "dotlrn_member_rel"}
    {referer "preferences"}
} -properties {
    context_bar:onevalue
    portal_id:onevalue
}

set context_bar {{$referer Admin} {Spam Community}}

if {[empty_string_p $community_id]} {
    set community_id [dotlrn_community::get_community_id]
}

dotlrn::require_user_admin_community $community_id

set sender_id [ad_conn user_id]
set portal_id [dotlrn_community::get_portal_id $community_id $sender_id]

db_1row select_sender_info {
    select parties.email as sender_email,
           persons.first_names as sender_first_names,
           persons.last_name as sender_last_name
    from parties,
         persons
    where parties.party_id = :sender_id
    and persons.person_id = :sender_id
}

form create spam_message

element create spam_message community_id \
    -label "Community ID" \
    -datatype integer \
    -widget hidden \
    -value $community_id

element create spam_message from \
    -label From \
    -datatype text \
    -widget text \
    -html {size 60} \
    -value $sender_email

element create spam_message rel_type \
    -label To \
    -datatype text \
    -widget select \
    -options {{Members dotlrn_member_rel} {Administrators dotlrn_admin_rel}} \
    -value $rel_type

element create spam_message subject \
    -label Subject \
    -datatype text \
    -widget text \
    -html {size 60}

element create spam_message message \
    -label Message \
    -datatype text \
    -widget textarea \
    -html {rows 10 cols 80 wrap soft}

element create spam_message referer \
    -label Referer \
    -datatype text \
    -widget hidden \
    -value $referer

if {[form is_valid spam_message]} {
    form get_values spam_message \
        community_id from rel_type subject message referer

    # YON: should redirect and close the connection here so that the user
    #      doesn't have to wait for the emails to get sent out.

    set segment_id [db_string select_rel_segment_id {}]

    # set the sql that selects the correct party_ids to spam
#    set sql "
#        select member_id as party_id
#        from party_approved_member_map
#        where party_id = $segment_id
#        and member_id <> $segment_id
#    "

#    spam_new_message \
#        -send_date [ns_fmttime [ns_time] "%Y-%m-%d %r"] \
#        -subject $subject \
#        -html $message \
#        -sql $sql \
#        -approved_p 't'

    # YON: since spam is broken and also not flexible enough yet, then we will
    #      send all the emails ourselves.

    # let's get some data we might need
    set community_name [dotlrn_community::get_community_name $community_id]
    set community_url [dotlrn_community::get_community_url $community_id]

    # replace some values in the subject and the message
    regsub -all {<sender_email>} $subject $from subject
    regsub -all {<sender_email>} $message $from message
#    regsub -all {<sender_first_names>} $subject $sender_first_names subject
#    regsub -all {<sender_first_names>} $message $sender_first_names message
#    regsub -all {<sender_last_name>} $subject $sender_last_name subject
#    regsub -all {<sender_last_name>} $message $sender_last_name message
    regsub -all {<community_name>} $subject $community_name subject
    regsub -all {<community_name>} $message $community_name message
    regsub -all {<community_url>} $subject $community_url subject
    regsub -all {<community_url>} $message $community_url message

    # loop through all the recepeints and send them the spam
    set errors ""
    db_foreach select_recepient_info {
        select parties.email,
               decode(acs_objects.object_type,
                      'user',
                      (select first_names
                       from persons
                       where person_id = parties.party_id),
                      'group',
                      (select group_name
                       from groups
                       where group_id = parties.party_id),
                      'rel_segment',
                      (select segment_name
                       from rel_segments
                       where segment_id = parties.party_id),
                      '') as first_names,
               decode(acs_objects.object_type,
                      'user',
                      (select last_name
                       from persons
                       where person_id = parties.party_id),
                      '') as last_name
        from party_approved_member_map,
             parties,
             acs_objects
        where party_approved_member_map.party_id = :segment_id
        and party_approved_member_map.member_id <> :segment_id
        and party_approved_member_map.member_id = parties.party_id
        and parties.party_id = acs_objects.object_id
    } {
        # replace some values in the subject and the message
        regsub -all {<email>} $subject $email subject
        regsub -all {<email>} $message $email message
        regsub -all {<first_names>} $subject $first_names subject
        regsub -all {<first_names>} $message $first_names message
        regsub -all {<last_name>} $subject $last_name subject
        regsub -all {<last_name>} $message $last_name message

        # send the email
        if {[catch {ns_sendmail $email $from $subject $message} errmsg]} {
            append errors "
<p>
  Failed to deliver to $email because:
  <blockquote>
    [ad_quotehtml $errmsg]
  </blockquote>
</p>
            "
        }
    }

    # if there were any errors sending the emails, then send an email to the
    # sender letting them know.
    if {![empty_string_p $errors]} {
        set error_subject "There were errors spamming community \"$community_name\""
        set error_message "
<p>
There were errors spamming community \"$community_name\".
</p>

<p>
The attempted message was:
</p>

<p>
<table width=\"50%\">
  <tr>
    <th align=\"left\">Subject</th>
    <td align=\"left\">$subject</td>
  </tr>
  <tr>
    <th align=\"left\">Message</th>
    <td align=\"left\">$message</td>
  </tr>
</table>
</p>

<p>
The errors were:
</p>

<p>
$errors
</p>
        "

        if {[catch {ns_sendmail $sender_email $sender_email $error_subject $error_message} errmsg]} {
            ad_return_error $error_subject $error_message
            ad_script_abort
        }
    }

    ad_returnredirect $referer
    ad_script_abort
}

ad_return_template
