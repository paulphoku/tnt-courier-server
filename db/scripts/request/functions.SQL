--ADD request
DROP FUNCTION IF EXISTS add_request(
    user_id TEXT,
    description TEXT,
    weight FLOAT,
    price FLOAT,
    destination_address TEXT,
    destination_lat FLOAT,
    destination_lng FLOAT,
    collection_address TEXT,
    collection_lat FLOAT,
    collection_lng FLOAT,
    reciever_name TEXT,
    reciever_cell TEXT,
    request_notes TEXT,
    schedule_time TIMESTAMP,
    polyline TEXT,
    addedondatetime TIMESTAMP
);
CREATE FUNCTION add_request (
    user_id TEXT,
    description TEXT,
    weight FLOAT,
    price FLOAT,
    destination_address TEXT,
    destination_lat FLOAT,
    destination_lng FLOAT,
    collection_address TEXT,
    collection_lat FLOAT,
    collection_lng FLOAT,
    reciever_name TEXT,
    reciever_cell TEXT,
    request_notes TEXT,
    schedule_time TIMESTAMP,
    polyline TEXT,
    addedondatetime TIMESTAMP
) RETURNS TEXT AS $$
DECLARE created_id TEXT;
BEGIN
INSERT INTO request (
        description,
        weight,
        price,
        destination_address,
        destination_lat,
        destination_lng,
        collection_address,
        collection_lat,
        collection_lng,
        reciever_name,
        reciever_cell,
        request_notes,
        schedule_time,
        polyline
    )
VALUES (
        add_request.description,
        add_request.weight,
        add_request.price,
        add_request.destination_address,
        add_request.destination_lat,
        add_request.destination_lng,
        add_request.collection_address,
        add_request.collection_lat,
        add_request.collection_lng,
        add_request.reciever_name,
        add_request.reciever_cell,
        add_request.request_notes,
        add_request.schedule_time,
        add_request.polyline
    )
RETURNING request_id INTO created_id;
INSERT INTO request_customer (
        cust_id,
        request_id,
        request_status,
        addedondatetime
    )
VALUES (
        add_request.user_id,
        created_id,
        'P',
        add_request.addedondatetime
    );
RETURN created_id;
END $$ LANGUAGE plpgsql;
/*
 
 SELECT  * FROM add_request(
 'user_id' ,
 'description' ,
 1 ,
 1 ,
 'destination_address' ,
 1 ,
 1 ,
 'collection_address' ,
 1 ,
 1 ,
 'reciever_name' ,
 'reciever_cell' ,
 'request_notes' ,
 '2023-01-01 00:00:00',    
 'polyline' ,
 '2023-01-01 00:00:00'
 );
 */
-------------------END----------------------------------------------
--GET request BY request ID
DROP FUNCTION IF EXISTS get_request(r_id TEXT);
CREATE FUNCTION get_request(r_id TEXT) RETURNS TABLE (
    id INT,
    request_id VARCHAR,
    description TEXT,
    weight FLOAT,
    price FLOAT,
    destination_address TEXT,
    destination_lat FLOAT,
    destination_lng FLOAT,
    collection_address TEXT,
    collection_lat FLOAT,
    collection_lng FLOAT,
    reciever_name TEXT,
    reciever_cell TEXT,
    request_notes TEXT,
    schedule_time TIMESTAMP,
    requested_by TEXT,
    status TEXT,
    polyline TEXT,
    addedondatetime TIMESTAMP
) AS $$ BEGIN RETURN QUERY
SELECT r.id,
    r.request_id,
    r.description,
    r.weight,
    r.price,
    r.destination_address,
    r.destination_lat,
    r.destination_lng,
    r.collection_address,
    r.collection_lat,
    r.collection_lng,
    r.reciever_name,
    r.reciever_cell,
    r.request_notes,
    r.schedule_time,
    rc.cust_id AS requested_by,
    rc.request_status,
    r.polyline,
    rc.addedondatetime
FROM request r,
    request_customer rc
WHERE rc.request_id = r.request_id
    AND r.request_id = get_request.r_id;
END $$ LANGUAGE plpgsql;
-- SELECT * FROM get_request('T23000001');
-------------------END----------------------------------------------
--GET request BY user ID
DROP FUNCTION IF EXISTS get_request_user(user_id TEXT);
CREATE FUNCTION get_request_user(user_id TEXT) RETURNS TABLE (
    id INT,
    request_id VARCHAR,
    description TEXT,
    weight FLOAT,
    price FLOAT,
    destination_address TEXT,
    destination_lat FLOAT,
    destination_lng FLOAT,
    collection_address TEXT,
    collection_lat FLOAT,
    collection_lng FLOAT,
    reciever_name TEXT,
    reciever_cell TEXT,
    request_notes TEXT,
    schedule_time TIMESTAMP,
    requested_by TEXT,
    status TEXT,
    polyline TEXT,
    addedondatetime TIMESTAMP
) AS $$ BEGIN RETURN QUERY
SELECT r.id,
    r.request_id,
    r.description,
    r.weight,
    r.price,
    r.destination_address,
    r.destination_lat,
    r.destination_lng,
    r.collection_address,
    r.collection_lat,
    r.collection_lng,
    r.reciever_name,
    r.reciever_cell,
    r.request_notes,
    r.schedule_time,
    rc.cust_id AS requested_by,
    rc.request_status,
    r.polyline,
    rc.addedondatetime
FROM request r,
    request_customer rc
WHERE rc.request_id = r.request_id
    AND rc.cust_id = get_request_user.user_id;
END $$ LANGUAGE plpgsql;
-- SELECT * FROM get_request_user('requested_by');
--GET ALL request
DROP FUNCTION IF EXISTS get_request();
CREATE FUNCTION get_request() RETURNS TABLE (
    id INT,
    request_id TEXT,
    description TEXT,
    weight FLOAT,
    price FLOAT,
    destination_address TEXT,
    destination_lat FLOAT,
    destination_lng FLOAT,
    collection_address TEXT,
    collection_lat FLOAT,
    collection_lng FLOAT,
    reciever_name TEXT,
    reciever_cell TEXT,
    request_notes TEXT,
    schedule_time TIMESTAMP,
    requested_by TEXT,
    status TEXT,
    polyline TEXT,
    addedondatetime TIMESTAMP
) AS $$ BEGIN RETURN QUERY
SELECT r.id,
    r.request_id,
    r.description,
    r.weight,
    r.price,
    r.destination_address,
    r.destination_lat,
    r.destination_lng,
    r.collection_address,
    r.collection_lat,
    r.collection_lng,
    r.reciever_name,
    r.reciever_cell,
    r.request_notes,
    r.schedule_time,
    rc.cust_id AS requested_by,
    rc.request_status,
    r.polyline,
    rc.addedondatetime
FROM request r,
    request_customer rc;
END $$ LANGUAGE plpgsql;
-- SELECT * FROM get_request();
-------------------END----------------------------------------------
--GET recent places
DROP FUNCTION IF EXISTS get_request_places(user_id TEXT);
CREATE FUNCTION get_request_places(user_id TEXT) RETURNS TABLE (
    structured_formatting TEXT,
    description TEXT,
    location JSON,
    isRecent BOOlEAN
) AS $$ BEGIN RETURN QUERY
SELECT r.destination_address as structured_formatting,
    '' as description,
    json_build_object(
        'lat',
        r.destination_lat,
        'lng',
        r.destination_lng
    ) as location,
    true as isRecent
FROM request r,
    request_customer rc
WHERE rc.request_id = r.request_id
    AND rc.cust_id = get_request_places.user_id
GROUP BY r.destination_address,
    r.destination_lat,
    r.destination_lng
LIMIT 5;
END $$ LANGUAGE plpgsql;
-- SELECT * FROM get_request_places('user_id');
-------------------END----------------------------------------------