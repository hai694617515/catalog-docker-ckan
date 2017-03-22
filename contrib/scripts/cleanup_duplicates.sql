begin;

    create temp table dup_packages as
        select p.id from package p
        join harvest_object ho on ho.package_id = p.id
        where ho.state = 'ERROR';


    update package set state = 'to_delete' where id in (select id from dup_packages);
    delete from resource_revision where package_id in (select id from package where state = 'to_delete' );
    delete from package_tag_revision where package_id in (select id from package where state = 'to_delete');
    delete from member_revision where table_id in (select id from package where state = 'to_delete');
    delete from package_extra_revision where package_id in (select id from package where state = 'to_delete');
    delete from package_revision where id in (select id from package where state = 'to_delete');
    delete from package_tag where package_id in (select id from package where state = 'to_delete');
    delete from resource_view where resource_id in (select id from resource where package_id in (select id from package where state = 'to_delete'));
    delete from resource where package_id in (select id from package where state = 'to_delete');
    delete from package_extra where package_id in (select id from package where state = 'to_delete');
    delete from member where table_id in (select id from package where state = 'to_delete');
    delete from harvest_object_error hoe using harvest_object ho where ho.id = hoe.harvest_object_id and package_id  in (select id from package where state = 'to_delete');
    delete from harvest_object_extra hoe using harvest_object ho where ho.id = hoe.harvest_object_id and package_id  in (select id from package where state = 'to_delete');
    delete from harvest_object where package_id in (select id from package where state = 'to_delete');
    delete from package_extent where package_id in (select id from package where state = 'to_delete');
    delete from package where id in (select id from package where state = 'to_delete'); 

    drop table dup_packages;

commit;
