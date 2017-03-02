--------------------------------------------------------------------------------
-- Delete Old Tags
--------------------------------------------------------------------------------
-- The following SQL script removes tags that aren't currently being referenced.

begin;
    delete from tag where id in (select tag_id from package_tag_revision where current is not true);
    delete from package_tag where tag_id in (select tag_id from package_tag_revision where current is not true);
    delete from revision where id in (select revision_id from package_tag_revision where current is not true);
    delete from package_tag_revision where current is not true;
commit;

