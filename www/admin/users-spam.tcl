# dotlrn/www/admin/users-spam.tcl

ad_page_contract {
    Spam a set of users.

    @author yon (yon@openforce.net)
    @creation-date 2002-02-14
    @version $Id$
} -query {
    users
    {referer "users-search"}
} -properties {
    context_bar:onevalue
}

set context_bar {{users Users} {users-search {User Search}} {Spam Users}}

set sender_id [ad_conn user_id]

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

element create spam_message users \
    -label "&nbsp;" \
    -datatype text \
    -widget hidden \
    -value $users

element create spam_message from \
    -label From \
    -datatype text \
    -widget text \
    -html {size 60} \
    -value $sender_email

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
        users from subject message referer

    # YON: should redirect and close the connection here so that the user
    #      doesn't have to wait for the emails to get sent out.

    set message_values [list]
    lappend message_values [list {<sender_email>} $from]

    spam::send \
        -recepients $users \
        -from $from \
        -real_from $sender_email \
        -subject $subject \
        -message $message \
        -message_values $message_values

    ad_returnredirect $referer
    ad_script_abort
}

ad_return_template