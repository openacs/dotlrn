# dotlrn/tcl/spam-procs.tcl

ad_library {

    Spam support procedures.

    @author yon (yon@openforce.net)
    @creation-date 2002-02-13
    @version $Id$

}

namespace eval spam {

    ad_proc -public interpolate {
        {-values:required}
        {-text:required}
    } {
        Interpolates a set of values into a string.

        @param values a list of tuples, each one consisting of a target string
                      and the value it is to be replaced with.
        @param text the string that is to be interpolated

        @return the interpolated string
    } {
        foreach tuple $values {
            regsub -all [lindex $tuple 0] $text [lindex $tuple 1] text
        }

        return $text
    }

    ad_proc -public send {
        {-recepients:required}
        {-from:required}
        {-real_from:required}
        {-subject:required}
        {-message:required}
        {-message_values:required}
    } {
        Send a spam to a set of users.

        @param recepients a list of party_id's; the recepients.
        @param from email address to set as "From"
        @param real_from real address of the sender to use in case of
                            errors.
        @param subject the subject of the email
        @param message the body of the email
        @param message_values a list of tuples of key/value pairs to
                              interpolate into the email
    } {

        set subject [interpolate -values $message_values -text $subject]
        set message [interpolate -values $message_values -text $message]

        # loop through all the recepients and send them the spam
        set errors ""
        db_foreach select_recepient_info "
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
            from parties,
                 acs_objects
            where party_id in ([join $recepients ,])
            and parties.party_id = acs_objects.object_id
        " {
            # replace some values in the subject and the message
            set values [list]
            lappend values [list {<email>} $email]
            lappend values [list {<first_names>} $first_names]
            lappend values [list {<last_name>} $last_name]

            set subject [interpolate -values $values -text $subject]
            set message [interpolate -values $values -text $message]

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
            set error_subject "There were errors with this spam"
            set error_message "
<p>
There were errors with this spam.
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

            if {[catch {ns_sendmail $real_from $real_from $error_subject $error_message} errmsg]} {
                ad_return_error $error_subject $error_message
                ad_script_abort
            }
        }
    }

}
