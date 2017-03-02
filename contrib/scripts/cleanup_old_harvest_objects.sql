--------------------------------------------------------------------------------
-- Delete Old Harvest Objects
--------------------------------------------------------------------------------
-- The following SQL script was critical in reducing the overall size of the
-- database and removing the revision records for harvest objects. 

begin;
    delete from harvest_object where id not in (
        select distinct on(ho.package_id) ho.id from harvest_object ho
        join package p on p.id = ho.package_id
        order by ho.package_id, ho.import_started desc
    );
    delete from harvest_object_error where harvest_object_id not in (select id from harvest_object);
    delete from harvest_object_extra where harvest_object_id not in (select id from harvest_object);
commit;
