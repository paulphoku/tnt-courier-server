--ADD user
DROP FUNCTION IF EXISTS add_user(
    user_role TEXT,
    address TEXT,
    id_no TEXT,
    contact TEXT,
    email TEXT,
    country TEXT,
    state TEXT,
    datecreated TIMESTAMP,
    modifiedondatetime TIMESTAMP,
    password TEXT,
    salt TEXT,
    gender TEXT,
    names TEXT,
    surname TEXT,
    photourl TEXT,
    username TEXT,
    dob TEXT
) CASCADE;
CREATE FUNCTION add_user (
    user_role TEXT,
    address TEXT,
    id_no TEXT,
    contact TEXT,
    email TEXT,
    country TEXT,
    state TEXT,
    datecreated TIMESTAMP,
    modifiedondatetime TIMESTAMP,
    password TEXT,
    salt TEXT,
    gender TEXT,
    names TEXT,
    surname TEXT,
    photourl TEXT,
    username TEXT,
    dob TEXT
) RETURNS TEXT AS $$
DECLARE created_id TEXT;
BEGIN
INSERT INTO t_user (
        uuid,
        address,
        id_no,
        contact,
        email,
        country,
        state,
        datecreated,
        modifiedondatetime,
        password,
        salt,
        gender,
        names,
        surname,
        photourl,
        username,
        dob
    )
VALUES (
        uuid_generate_v1(),
        add_user.address,
        add_user.id_no,
        add_user.contact,
        add_user.email,
        add_user.country,
        add_user.state,
        add_user.datecreated,
        add_user.modifiedondatetime,
        add_user.password,
        add_user.salt,
        add_user.gender,
        add_user.names,
        add_user.surname,
        add_user.photourl,
        add_user.username,
        add_user.dob
    )
RETURNING uuid INTO created_id;
INSERT INTO t_user_role (
        user_id,
        role,
        datecreated,
        modifiedondatetime
    )
VALUES(
        created_id,
        add_user.user_role,
        add_user.datecreated,
        add_user.datecreated
    );
RETURN created_id;
END $$ LANGUAGE plpgsql;
/*
 SELECT  * FROM add_user(
 'user_role' ,
 'address' ,
 'id_no' ,
 'contact' ,
 'email' ,
 'country' ,
 'state' ,
 '2023-01-01 00:00:00' ,
 '2023-01-01 00:00:00' ,
 'password' ,
 'salt' ,
 'gender' ,
 'names' ,
 'surname' ,
 'photourl' ,
 'username' ,
 '2023-01-01 00:00:00' 
 );
 */
-------------------END----------------------------------------------
--GET user BY user ID
DROP FUNCTION IF EXISTS get_user(user_id TEXT);
CREATE FUNCTION get_user(user_id TEXT) RETURNS TABLE (
    uuid TEXT,
    user_role TEXT,
    address TEXT,
    id_no TEXT,
    contact TEXT,
    email TEXT,
    country TEXT,
    state TEXT,
    datecreated TIMESTAMP,
    modifiedondatetime TIMESTAMP,
    password TEXT,
    salt TEXT,
    gender TEXT,
    names TEXT,
    surname TEXT,
    photourl TEXT,
    username TEXT,
    dob TEXT
) AS $$ BEGIN RETURN QUERY
SELECT u.uuid,
    r.role,
    u.address,
    u.id_no,
    u.contact,
    u.email,
    u.country,
    u.state,
    u.datecreated,
    u.modifiedondatetime,
    u.password,
    u.salt,
    u.gender,
    u.names,
    u.surname,
    u.photourl,
    u.username,
    u.dob
FROM t_user u,
    t_user_role r
WHERE r.user_id = u.uuid
    AND u.uuid = get_user.user_id;
END $$ LANGUAGE plpgsql;
-- SELECT * FROM get_user('1e4778c0-d5f1-11ed-b9bb-83fbde88e6bf');
-------------------END----------------------------------------------
-- SELECT * FROM get_user(1);
-------------------END----------------------------------------------
--GET ALL user
DROP FUNCTION IF EXISTS get_user();
CREATE FUNCTION get_user() RETURNS TABLE (
    uuid TEXT,
    user_role TEXT,
    address TEXT,
    id_no TEXT,
    contact TEXT,
    email TEXT,
    country TEXT,
    state TEXT,
    datecreated TIMESTAMP,
    modifiedondatetime TIMESTAMP,
    password TEXT,
    salt TEXT,
    gender TEXT,
    names TEXT,
    surname TEXT,
    photourl TEXT,
    username TEXT,
    dob TEXT
) AS $$ BEGIN RETURN QUERY
SELECT u.uuid,
    r.role,
    u.address,
    u.id_no,
    u.contact,
    u.email,
    u.country,
    u.state,
    u.datecreated,
    u.modifiedondatetime,
    u.password,
    u.salt,
    u.gender,
    u.names,
    u.surname,
    u.photourl,
    u.username,
    u.dob
FROM t_user u,
    t_user_role r
WHERE r.user_id = u.uuid;
END $$ LANGUAGE plpgsql;
-- SELECT * FROM get_user();
-------------------END----------------------------------------------