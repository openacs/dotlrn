--
-- Implementation of the profile provider interface for dotLRN Admins.
--
-- @author <a href="mailto:yon@openforce.net">yon@openforce.net</a>
-- @version $Id$
--

begin

    -- create the implementation
    select acs_sc_impl__new(
        'profile_provider',
        'dotlrn_admin_profile_provider',
        'dotlrn_admin_profile_provider'
    );

    -- add the bindings to the method implementations

        -- name method
        select acs_sc_impl_alias__new(
            'profile_provider',
            'dotlrn_admin_profile_provider',
            'name',
            'dotlrn_admin_profile_provider::name',
            'TCL'
        );

        -- prettyName method
        select acs_sc_impl_alias__new(
            'profile_provider',
            'dotlrn_admin_profile_provider',
            'prettyName',
            'dotlrn_admin_profile_provider::prettyName',
            'TCL'
        );

        -- render method
        select acs_sc_impl_alias__new(
            'profile_provider',
            'dotlrn_admin_profile_provider',
            'render',
            'dotlrn_admin_profile_provider::render',
            'TCL'
        );

    -- bind this implementation to the interface it implements
    select acs_sc_binding__new(
        'profile_provider',
        'dotlrn_admin_profile_provider'
    );

end;
