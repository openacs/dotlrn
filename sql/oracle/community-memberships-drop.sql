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
-- drop the dotLRN communities membership model
--
-- @author Ben Adida (ben@openforce.net)
-- @author yon (yon@openforce.net)
-- @creation-date  November 6th, 2001
-- @version $Id$
--


drop trigger dotlrn_member_emails_trigger;
drop sequence dotlrn_member_emails_seq;
drop table dotlrn_member_emails;
drop view dotlrn_admin_rels_full;
drop table dotlrn_admin_rels;
drop view dotlrn_member_rels_approved;
drop view dotlrn_member_rels_full;
drop table dotlrn_member_rels;
