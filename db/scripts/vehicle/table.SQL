DROP TABLE IF EXISTS vehicle CASCADE;

CREATE TABLE IF NOT EXISTS vehicle (
    id SERIAL PRIMARY KEY NOT NULL,
    license_no TEXT NOT NULL,
    registration_no TEXT NULL,
    make TEXT NULL,
    model TIMESTAMP NULL,
    year FLOAT NULL,
    photo_url TEXT NULL,
    weight FLOAT NULL
)