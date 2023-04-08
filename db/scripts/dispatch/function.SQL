--ADD DISPATCH
DROP FUNCTION IF EXISTS add_dispatch;
CREATE FUNCTION add_dispatch (
    driver_id TEXT,
    date_created TIMESTAMP,
    schedule_time TEXT,
    manifest_id TEXT,
    dispatched_by TEXT
) RETURNS TEXT AS $$
DECLARE created_id TEXT;
BEGIN
INSERT INTO dispatch (
        driver_id,
        date_created,
        schedule_time,
        manifest_id,
        dispatched_by
    )
VALUES (
        add_dispatch.driver_id,
        add_dispatch.date_created,
        add_dispatch.schedule_time,
        add_dispatch.manifest_id,
        add_dispatch.dispatched_by
    )
RETURNING id INTO created_id;
RETURN created_id;
END $$ LANGUAGE plpgsql;
/*
 
 SELECT  * FROM add_dispatch(
 'driver_id',
 '2023-01-01 00:00:00',
 '2023-01-01 00:00:00',
 'manifest_id',
 'dispatched_by');
 */
-------------------END----------------------------------------------
--GET DISPATCH BY USER
DROP FUNCTION IF EXISTS get_dispatch(user_id TEXT);
CREATE FUNCTION get_dispatch(user_id TEXT) RETURNS TABLE (
    id INT,
    driver_id TEXT,
    date_created TIMESTAMP,
    schedule_time TEXT,
    manifest_id TEXT,
    dispatched_by TEXT
) AS $$ BEGIN RETURN QUERY
SELECT d.id,
    d.driver_id,
    d.date_created,
    d.schedule_time,
    d.manifest_id,
    d.dispatched_by
FROM dispatch d
WHERE d.dispatched_by = get_dispatch.user_id;
END $$ LANGUAGE plpgsql;
-- SELECT * FROM get_dispatch('user_id');
-------------------END----------------------------------------------
--GET ALL DISPATCH
DROP FUNCTION IF EXISTS get_dispatch();
CREATE FUNCTION get_dispatch() RETURNS TABLE (
    id INT,
    driver_id TEXT,
    date_created TIMESTAMP,
    schedule_time TEXT,
    manifest_id TEXT,
    dispatched_by TEXT
) AS $$ BEGIN RETURN QUERY
SELECT d.id,
    d.driver_id,
    d.date_created,
    d.schedule_time,
    d.manifest_id,
    d.dispatched_by
FROM dispatch d;
END $$ LANGUAGE plpgsql;
-- SELECT * FROM get_dispatch();
-------------------END----------------------------------------------