DROP TABLE IF EXISTS device CASCADE;

CREATE TABLE IF NOT EXISTS device (
    id SERIAL PRIMARY KEY NOT NULL,
    fcm_token TEXT NOT NULL,
    os TEXT NULL,
    ua TEXT NULL,
    manufacture TEXT NULL,
    date_modified TIMESTAMP NULL
);