DROP TABLE IF EXISTS request_collection CASCADE;

CREATE TABLE IF NOT EXISTS request_collection (
    id SERIAL PRIMARY KEY NOT NULL,
    request_id TEXT NOT NULL,
    driver_id TEXT NULL,
    status	TEXT NULL,
    photo_url TEXT NULL,
    date_created TIMESTAMP NULL,
    date_modified TIMESTAMP NULL
)