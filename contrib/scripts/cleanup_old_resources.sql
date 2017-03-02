--------------------------------------------------------------------------------
-- Delete Old Resources
--------------------------------------------------------------------------------
-- The following script removes all old resources, which are the links to
-- external resources like OPeNDAP, HTML, ERDDAP etc. As mentioned with the
-- dangling records bullet, we found that several hundred thousand resource
-- records had no attached package.

begin;
    delete from revision where id in (select revision_id from resource_revision where current is not true);
    delete from resource_revision where current is not true;
commit;


