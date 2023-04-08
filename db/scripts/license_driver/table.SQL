DROP TABLE IF EXISTS license_driver CASCADE;
CREATE TABLE IF NOT EXISTS license_driver (
    id SERIAL PRIMARY KEY NOT NULL,
    driver_id TEXT NOT NULL,
    license_no TEXT NULL,
    addedondatetime TIMESTAMP NULL,
    date_modified TIMESTAMP NULL,
    photo_url TEXT NULL
);