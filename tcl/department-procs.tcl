ad_library {
    Procs to manage dotLRN Departments

    @author yon (yon@openforce.net)
    @creation-date 2001-01-20
    @version $Id$
}

namespace eval dotlrn_department {

    ad_proc -public new {
        {-pretty_name:required}
        {-description ""}
        {-external_url ""}
    } {
        Create a new department.
    } {

        set department_key [dotlrn::generate_key -name $pretty_name]
        
        # check if the name is already in use, if so, complain loudly
        if {![check_department_key_valid_p \
                -department_key $department_key]} {
            ad_return_complaint \
                    1 \
                    "The name <strong>$pretty_name</strong> is already in use. \n
                       Please select a different name."
        }

        db_transaction {
            dotlrn_community::new_type \
                -community_type_key "$department_key" \
                -parent_type "dotlrn_class_instance" \
                -pretty_name $pretty_name \
                -description $description \
                -url_part $department_key

            db_dml insert_department {}
        }
    }

    ad_proc -public check_department_key_valid_p {
        {-department_key:required}
    } {
        Checks if the key is in use as a department key
    } {
        if {[db_0or1row check {}]} {
            return 0
        } else {
            return 1
        }
    }

    ad_proc -public select_as_list {
    } {
        Select all departments as a list of tuples of format:
            "pretty_name department_key"
    } {
        return [db_list_of_lists select_departments {}]
    }

}
