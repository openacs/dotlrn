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
-- drop dotLRN clubs model
--
-- @author Ben Adida (ben@openforce.net)
-- @author yon (yon@openforce.net)
-- @author dan chak (chak@openforce.net)
-- @creation-date August 18th, 2001
-- @version $Id$
--

select drop_package('dotlrn_club');
drop view dotlrn_clubs_full;
drop table dotlrn_clubs;
