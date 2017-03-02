--------------------------------------------------------------------------------
-- Delete User Activity Records
--------------------------------------------------------------------------------
-- The following SQL script removes all activity records from the database.
-- Activity records are the results of users clicking around in the UI.

begin;
    delete from activity_detail cascade;
    delete from activity;
commit;
