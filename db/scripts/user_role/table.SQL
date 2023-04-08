DROP TABLE IF EXISTS t_user_role CASCADE;
CREATE TABLE IF NOT EXISTS t_user_role (
    id SERIAL PRIMARY KEY NOT NULL,
    user_id TEXT UNIQUE NOT NULL,
    role TEXT NULL,
    datecreated TIMESTAMP NOT NULL,
    modifiedondatetime TIMESTAMP NULL
);