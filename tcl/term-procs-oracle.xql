<?xml version="1.0"?>
<!--

  Copyright (C) 2001, 2002 OpenForce, Inc.

  This file is part of dotLRN.

  dotLRN is free software; you can redistribute it and/or modify it under the
  terms of the GNU General Public License as published by the Free Software
  Foundation; either version 2 of the License, or (at your option) any later
  version.

  dotLRN is distributed in the hope that it will be useful, but WITHOUT ANY
  WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
  FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more
  details.

-->


<queryset>
    <rdbms><type>oracle</type><version>8.1.6</version></rdbms>

    <fullquery name="dotlrn_term::new.insert_term">
        <querytext>
            insert
            into dotlrn_terms
            (term_id, term_name, term_year, start_date, end_date)
            values
            (acs_object_id_seq.nextval, :term_name, :term_year, to_date(:start_date, :date_format), to_date(:end_date, :date_format))
        </querytext>
    </fullquery>

    <fullquery name="dotlrn_term::edit.update_term">
        <querytext>
            update dotlrn_terms
            set term_name = :term_name,
                term_year = :term_year,
                start_date = to_date(:start_date, :date_format),
                end_date = to_date(:end_date, :date_format)
            where term_id = :term_id
        </querytext>
    </fullquery>

    <fullquery name="dotlrn_term::get_start_date.get_start_date">
        <querytext>
            select to_char(dotlrn_terms.start_date, :date_format) as start_date,
                   to_char(dotlrn_terms.start_date, 'YYYY') as year,
                   to_char(dotlrn_terms.start_date, 'MM') as month,
                   to_char(dotlrn_terms.start_date, 'DD') as day
            from dotlrn_terms
            where dotlrn_terms.term_id = :term_id
        </querytext>
    </fullquery>

    <fullquery name="dotlrn_term::get_end_date.get_end_date">
        <querytext>
            select to_char(dotlrn_terms.end_date, :date_format) as end_date,
                   to_char(dotlrn_terms.end_date, 'YYYY') as year,
                   to_char(dotlrn_terms.end_date, 'MM') as month,
                   to_char(dotlrn_terms.end_date, 'DD') as day
            from dotlrn_terms
            where dotlrn_terms.term_id = :term_id
        </querytext>
    </fullquery>
</queryset>
