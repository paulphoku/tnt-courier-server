DROP TABLE IF EXISTS vendor CASCADE;

CREATE TABLE IF NOT EXISTS vendor (
    id SERIAL PRIMARY KEY NOT NULL,
    address TEXT NOT NULL,
    vend_code TEXT NULL,
    date_created TIMESTAMP NULL,
    date_modified TIMESTAMP NULL
)