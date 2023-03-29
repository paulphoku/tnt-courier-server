DROP TABLE IF EXISTS device_user CASCADE;

CREATE TABLE IF NOT EXISTS device_user (
    id SERIAL PRIMARY KEY NOT NULL,
    user_id TEXT NOT NULL,
    device_id TEXT NULL,
    date_created TIMESTAMP NULL
)