--GET ALL DEVICES
DROP FUNCTION IF EXISTS get_device();
CREATE FUNCTION get_device() RETURNS TABLE (
       fcm_token TEXT,
       os TEXT,
       ua TEXT,
       manufacture TEXT,
       date_modified TIMESTAMP,
       device_type TEXT
) AS $$ BEGIN RETURN QUERY
SELECT d.fcm_token,
       d.os,
       d.ua,
       d.manufacture,
       d.date_modified,
       d.device_type
FROM device d;
END $$ LANGUAGE plpgsql;
-- SELECT * FROM get_all_device ();
-------------------END----------------------------------------------
--GET USER DEVICES
DROP FUNCTION IF EXISTS get_device(user_id TEXT);
CREATE FUNCTION get_device(user_id TEXT) RETURNS TABLE (
       fcm_token TEXT,
       os TEXT,
       ua TEXT,
       manufacture TEXT,
       date_modified TIMESTAMP,
       device_type TEXT
) AS $$ BEGIN RETURN QUERY
SELECT d.fcm_token,
       d.os,
       d.ua,
       d.manufacture,
       d.date_modified,
       d.device_type
FROM device d,
       device_user du
WHERE d.id = du.device_id
       AND du.user_id = get_device.user_id;
END $$ LANGUAGE plpgsql;
-- SELECT *FROM get_device ('user_id');
-------------------END----------------------------------------------
--ADD USER DEVICE
DROP FUNCTION IF EXISTS add_device;
CREATE FUNCTION add_device (
       user_id TEXT,
       fcm_token TEXT,
       os TEXT,
       ua TEXT,
       manufacture TEXT,
       date_modified TIMESTAMP,
       device_type TEXT
) RETURNS TEXT AS $$
DECLARE created_id TEXT;
BEGIN
INSERT INTO device (
              id,
              fcm_token,
              os,
              ua,
              manufacture,
              date_modified,
              device_type
       )
VALUES (
              uuid_generate_v1(),
              add_device.fcm_token,
              add_device.os,
              add_device.ua,
              add_device.manufacture,
              add_device.date_modified,
              add_device.device_type
       )
RETURNING id INTO created_id;
INSERT INTO device_user (user_id, device_id, date_created)
VALUES (
              add_device.user_id,
              created_id,
              add_device.date_modified
       );
RETURN created_id;
END $$ LANGUAGE plpgsql;
/*
 
 SELECT  * FROM add_device
 ( 'user_id', 'fcm_token', 'os', 'ua', 'manufacture', '2023-01-01 00:00:00', 'mobile'); */
-------------------END----------------------------------------------