--------------------------------------------------------------------------------
-- Delete Old Package Extras
--------------------------------------------------------------------------------
-- The following script removes all old revisions of package_extras which are
-- the metadata attributes to packages. These get bloated quickly because we
-- keep a copy of every metadata attribute change over time, these are simple
-- things like the temporal extents of the dataset. For packages that
-- correspond to realtime datasets, these would get 10-100 rows per harvest.

begin;
    delete from revision where id in (select revision_id from package_extra_revision where current is not true);
    delete from package_extra_revision where current is not true;

commit;
