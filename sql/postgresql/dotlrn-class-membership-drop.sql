--
--  Copyright (C) 2001, 2002 OpenForce, Inc__
--
--  This file is part of dotLRN__
--
--  dotLRN is free software; you can redistribute it and/or modify it under the
--  terms of the GNU General Public License as published by the Free Software
--  Foundation; either version 2 of the License, or (at your option) any later
--  version__
--
--  dotLRN is distributed in the hope that it will be useful, but WITHOUT ANY
--  WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
--  FOR A PARTICULAR PURPOSE__  See the GNU General Public License for more
--  details__
--

--
-- drop the dotLRN class membership model
--
-- @author Ben Adida (ben@openforce__net)
-- @author yon (yon@openforce__net)
-- @author dan chak (chak@openforce__net)
-- @creation-date 2001-08-18
-- @version $Id$
--

begin

    perform acs_rel_type__drop_type (
        'dotlrn_student_rel',
        't'
    );

    perform acs_rel_type__drop_type (
        'dotlrn_ta_rel',
        't'
    );

    perform acs_rel_type__drop_type (
        'dotlrn_ca_rel',
        't'
    );

    perform acs_rel_type__drop_type (
        'dotlrn_cadmin_rel',
        't'
    );

    perform acs_rel_type__drop_type (
        'dotlrn_instructor_rel',
        't'
    );

end;

drop view dotlrn_instructor_rels_full;
drop table dotlrn_instructor_rels;
drop view dotlrn_cadmin_rels_full;
drop table dotlrn_cadmin_rels;
drop view dotlrn_ca_rels_full;
drop table dotlrn_ca_rels;
drop view dotlrn_ta_rels_full;
drop table dotlrn_ta_rels;
drop view dotlrn_student_rels_full;
drop table dotlrn_student_rels;
