DROP TABLE IF EXISTS dispatch CASCADE;

CREATE TABLE IF NOT EXISTS dispatch (
    id SERIAL PRIMARY KEY NOT NULL,
    driver_id TEXT NOT NULL,
    date_created TIMESTAMP NULL,
    schedule_time TEXT NULL,
    manifest_id TEXT NULL
)