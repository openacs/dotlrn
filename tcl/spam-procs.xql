<?xml version="1.0"?>

<queryset>

    <fullquery name="spam::send.select_recepient_info">
        <querytext>
            select parties.email,
                   persons.first_names,
                   persons.last_name
            from parties, persons
            where party_id in ([join $recepients ,])
            and parties.party_id = persons.person_id
        </querytext>
    </fullquery>

</queryset>
