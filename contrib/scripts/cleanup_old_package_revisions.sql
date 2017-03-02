--------------------------------------------------------------------------------
-- Delete Old Package Revisions
--------------------------------------------------------------------------------
-- The following SQL script removes old revisions of packages.

begin;
    delete from revision where id in (select revision_id from package_revision where current is not true);
    delete from package_revision where current is not true;
commit;
