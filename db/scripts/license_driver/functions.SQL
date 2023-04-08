--ADD license_driver
DROP FUNCTION IF EXISTS add_license_driver();
CREATE FUNCTION add_license_driver (
    driver_id TEXT,
    license_no TEXT,
    addedondatetime TIMESTAMP,
    date_modified TIMESTAMP,
    photo_url TEXT
) RETURNS TEXT AS $$
DECLARE created_id TEXT;
BEGIN
INSERT INTO license_driver (
        driver_id,
        license_no,
        addedondatetime,
        date_modified,
        photo_url
    )
VALUES (
        add_license_driver.driver_id,
        add_license_driver.license_no,
        add_license_driver.addedondatetime,
        add_license_driver.date_modified,
        add_license_driver.photo_url
    )
RETURNING id INTO created_id;
RETURN created_id;
END $$ LANGUAGE plpgsql;
/*
 
 SELECT  * FROM add_license_driver(
 'driver_id',
 'license_no',
 '2023-01-01 00:00:00',
 '2023-01-01 00:00:00',
 'photo_url'
 );
 */
-------------------END----------------------------------------------
--GET license_driver BY ID
DROP FUNCTION IF EXISTS get_license_driver(license_driver_id TEXT);
CREATE FUNCTION get_license_driver(license_driver_id TEXT) RETURNS TABLE (
    driver_id TEXT,
    license_no TEXT,
    addedondatetime TIMESTAMP,
    date_modified TIMESTAMP,
    photo_url TEXT
) AS $$ BEGIN RETURN QUERY
SELECT l.driver_id,
    l.license_no,
    l.addedondatetime,
    l.date_modified,
    l.photo_url
FROM license_driver l
WHERE l.driver_id = get_license_driver.license_driver_id;
END $$ LANGUAGE plpgsql;
-- SELECT * FROM get_license_driver('driver_id');
-------------------END----------------------------------------------
--GET ALL license_driver
DROP FUNCTION IF EXISTS get_license_driver();
CREATE FUNCTION get_license_driver() RETURNS TABLE (
    driver_id TEXT,
    license_no TEXT,
    addedondatetime TIMESTAMP,
    date_modified TIMESTAMP,
    photo_url TEXT
) AS $$ BEGIN RETURN QUERY
SELECT l.driver_id,
    l.license_no,
    l.addedondatetime,
    l.date_modified,
    l.photo_url
FROM license_driver l;
END $$ LANGUAGE plpgsql;
-- SELECT * FROM get_license_driver();
-------------------END----------------------------------------------