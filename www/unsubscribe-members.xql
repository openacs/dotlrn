<?xml version="1.0"?>

<queryset>
    <rdbms><type>oracle</type><version>8.1.6</version></rdbms>

    <fullquery name="update_autosubscribe_p">
        <querytext>
            update forums_forums
            set autosubscribe_p = 'f'
            where forum_id = :forum_id
        </querytext>
    </fullquery>

</queryset>
