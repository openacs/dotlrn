--
--  Copyright (C) 2001, 2002 MIT
--
--  This file is part of dotLRN.
--
--  dotLRN is free software; you can redistribute it and/or modify it under the
--  terms of the GNU General Public License as published by the Free Software
--  Foundation; either version 2 of the License, or (at your option) any later
--  version.
--
--  dotLRN is distributed in the hope that it will be useful, but WITHOUT ANY
--  WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
--  FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more
--  details.
--

--
-- Sanitize the dotLRN Professor package
--
-- @author <a href="mailto:yon@openforce.net">yon@openforce.net</a>
-- @author dan chak (chak@openforce.net)
-- @version $Id$
--

create function inline_0() 
returns integer as '
declare
    foo                         integer;
begin

    select min(segment_id)
    into foo
    from rel_segments
    where segment_name = ''dotLRN Full Profiled Professors'';

    perform rel_segment__delete(
        foo
    );

    perform acs_rel_type__drop_type(
        ''dotlrn_full_professor_profile_rel'',
        ''t''
    );

    return 0;

end;
' language 'plpgsql';
select inline_0();
drop function inline_0();

create function inline_1() 
returns integer as '
declare
    foo                         integer;
begin

    select min(segment_id)
    into foo
    from rel_segments
    where segment_name = ''dotLRN Profiled Professors'';

    perform rel_segment__delete(
        foo
    );

    select min(group_id)
    into foo
    from profiled_groups
    where profile_provider = (select min(impl_id)
                              from acs_sc_impls
                              where impl_name = ''dotlrn_professor_profile_provider'');

    delete
    from dotlrn_user_types
    where group_id = foo;

    perform profiled_group__delete(
        foo
    );

    perform acs_rel_type__drop_type(
        ''dotlrn_professor_profile_rel'',
        ''t''
    );

    return 0;
end;
' language 'plpgsql';
select inline_1();
drop function inline_1();
