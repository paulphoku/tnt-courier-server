DROP TABLE IF EXISTS t_user CASCADE;
CREATE TABLE IF NOT EXISTS t_user (
    id SERIAL PRIMARY KEY NOT NULL,
    uuid TEXT UNIQUE NOT NULL,
    address TEXT NULL,
    id_no TEXT NULL,
    contact TEXT NULL,
    email TEXT NULL,
    country TEXT NULL,
    state TEXT NULL,
    datecreated TIMESTAMP NOT NULL,
    modifiedondatetime TIMESTAMP NOT NULL,
    password TEXT NULL,
    salt TEXT NULL,
    gender TEXT NULL,
    names TEXT NULL,
    surname TEXT NULL,
    photourl TEXT NULL,
    username TEXT NULL,
    dob TIMESTAMP NULL
);