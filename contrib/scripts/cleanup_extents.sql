--------------------------------------------------------------------------------
-- Delete Dangling Extents Records
--------------------------------------------------------------------------------
-- The following SQL script removes all package_extent records that don't
-- actively belong to any packages.

begin;
    delete from package_extent where package_id not in (select id from package);
commit;
