--
-- Implementation of the profile provider interface for dotlrn users.
--
-- @author <a href="mailto:yon@openforce.net">yon@openforce.net</a>
-- @version $Id$
--

declare
    foo                         integer;
begin

    -- drop the binding between this implementation and the interface it
    -- implements.
    acs_sc_binding.delete(
        contract_name => 'profile_provider',
        impl_name => 'dotlrn_user_profile_provider'
    );

    -- drop the bindings to the method implementations

        -- name method
        foo := acs_sc_impl.delete_alias(
            impl_contract_name => 'profile_provider',
            impl_name => 'dotlrn_user_profile_provider',
            impl_operation_name => 'name'
        );

        -- prettyName method
        foo := acs_sc_impl.delete_alias(
            impl_contract_name => 'profile_provider',
            impl_name => 'dotlrn_user_profile_provider',
            impl_operation_name => 'prettyName'
        );

        -- render method
        foo := acs_sc_impl.delete_alias(
            impl_contract_name => 'profile_provider',
            impl_name => 'dotlrn_user_profile_provider',
            impl_operation_name => 'render'
        );

    -- drop the implementation
    acs_sc_impl.delete(
        impl_contract_name => 'profile_provider',
        impl_name => 'dotlrn_user_profile_provider'
    );

end;
/
show errors
