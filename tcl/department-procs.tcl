ad_library {
    Procs to manage dotLRN Departments

    @author yon (yon@openforce.net)
    @creation-date 2001-01-20
    @version $Id$
}

namespace eval dotlrn_department {

    ad_proc -public new {
        {-department_key:required}
        {-pretty_name:required}
        {-description ""}
        {-external_url ""}
    } {
        Create a new department.
    } {
        db_transaction {
            dotlrn_community::new_type \
                -community_type_key $department_key \
                -parent_type "dotlrn_class_instance" \
                -pretty_name $pretty_name \
                -description $description

            db_dml insert_department {}
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
