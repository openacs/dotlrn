--
-- Implementation of the profile provider interface for dotLRN Externals.
--
-- @author <a href="mailto:yon@openforce.net">yon@openforce.net</a>
-- @version $Id$
--

declare
    foo                         integer;
begin

    -- create the implementation
    foo := acs_sc_impl.new(
        impl_contract_name => 'profile_provider',
        impl_name => 'dotlrn_external_profile_provider',
        impl_owner_name => 'dotlrn_external_profile_provider'
    );

    -- add the bindings to the method implementations

        -- name method
        foo := acs_sc_impl.new_alias(
            impl_contract_name => 'profile_provider',
            impl_name => 'dotlrn_external_profile_provider',
            impl_operation_name => 'name',
            impl_alias => 'dotlrn_external_profile_provider::name',
            impl_pl => 'TCL'
        );

        -- prettyName method
        foo := acs_sc_impl.new_alias(
            impl_contract_name => 'profile_provider',
            impl_name => 'dotlrn_external_profile_provider',
            impl_operation_name => 'prettyName',
            impl_alias => 'dotlrn_external_profile_provider::prettyName',
            impl_pl => 'TCL'
        );

        -- render method
        foo := acs_sc_impl.new_alias(
            impl_contract_name => 'profile_provider',
            impl_name => 'dotlrn_external_profile_provider',
            impl_operation_name => 'render',
            impl_alias => 'dotlrn_external_profile_provider::render',
            impl_pl => 'TCL'
        );

    -- bind this implementation to the interface it implements
    acs_sc_binding.new(
        contract_name => 'profile_provider',
        impl_name => 'dotlrn_external_profile_provider'
    );

end;
/
show errors
