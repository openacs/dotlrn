--
--  Copyright (C) 2001, 2002 OpenForce, Inc.
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
-- Create the dotLRN Professors package
--
-- @author <a href="mailto:yon@openforce.net">yon@openforce.net</a>
-- @version $Id$
--

create table dotlrn_professor_profile_rels (
    rel_id                      integer
                                constraint dotlrn_prof_rels_rel_id_fk
                                references dotlrn_user_profile_rels (rel_id)
                                constraint dotlrn_prof_profile_rels_pk
                                primary key
);

\i professor-profile-provider-create.sql
\i professors-init.sql
\i professors-package-create.sql
