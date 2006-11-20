ad_library {

    community-init : schedules community procs

    @author Sven Schmitt s.lrn@gmx.net
    @creation-date 2005-04-04

}

# Schedule proc to remove banned users from communties they are still members of
# ad_schedule_proc -thread t 86400 dotlrn_community::remove_banned_users_from_all
