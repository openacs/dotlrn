
-- Store emails to be sent when user joins a community
create table dotlrn_member_emails (
        email_id	serial primary key,
        community_id    integer references dotlrn_communities_all
                        on delete cascade,
-- Might be useful
        type            text default 'on join',
        from_addr       text,
        subject         text,
        email           text,
        enabled_p       boolean default 'f',
	                constraint dotlrn_member_emails_un unique(community_id, type)
);
