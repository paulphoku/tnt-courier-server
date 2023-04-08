--ADD manifest
DROP FUNCTION IF EXISTS add_manifest();
CREATE FUNCTION add_manifest (
    ploc_id TEXT,
    date_created TIMESTAMP,
    packed_by TEXT
) RETURNS TEXT AS $$
DECLARE created_id TEXT;
BEGIN
INSERT INTO manifest (
        ploc_id,
        date_created,
        packed_by
    )
VALUES (
        add_manifest.ploc_id,
        add_manifest.date_created,
        add_manifest.packed_by
    )
RETURNING id INTO created_id;
RETURN created_id;
END $$ LANGUAGE plpgsql;
/*
 
 SELECT  * FROM add_manifest('ploc_id',
 '2023-01-01 00:00:00', 'packed_by'
 );
 */
-------------------END----------------------------------------------
--GET manifest BY user ID
DROP FUNCTION IF EXISTS get_manifest(user_id TEXT);
CREATE FUNCTION get_manifest(user_id TEXT) RETURNS TABLE (
    id INT,
    ploc_id TEXT,
    date_created TIMESTAMP,
    packed_by TEXT
) AS $$ BEGIN RETURN QUERY
SELECT m.id,
    m.ploc_id,
    m.date_created,
    m.packed_by
FROM manifest m
WHERE m.packed_by = get_manifest.user_id;
END $$ LANGUAGE plpgsql;
-- SELECT * FROM get_manifest('packed_by');
-------------------END----------------------------------------------
--GET manifest BY manifest_id
DROP FUNCTION IF EXISTS get_manifest(manifest_id INT);
CREATE FUNCTION get_manifest(manifest_id INT) RETURNS TABLE (
    id INT,
    ploc_id TEXT,
    date_created TIMESTAMP,
    packed_by TEXT
) AS $$ BEGIN RETURN QUERY
SELECT m.id,
    m.ploc_id,
    m.date_created,
    m.packed_by
FROM manifest m
WHERE m.id = get_manifest.manifest_id;
END $$ LANGUAGE plpgsql;
-- SELECT * FROM get_manifest(1);
-------------------END----------------------------------------------
--GET ALL manifest
DROP FUNCTION IF EXISTS get_manifest();
CREATE FUNCTION get_manifest() RETURNS TABLE (
    id INT,
    ploc_id TEXT,
    date_created TIMESTAMP,
    packed_by TEXT
) AS $$ BEGIN RETURN QUERY
SELECT m.id,
    m.ploc_id,
    m.date_created,
    m.packed_by
FROM manifest m;
END $$ LANGUAGE plpgsql;
-- SELECT * FROM get_manifest();
-------------------END----------------------------------------------