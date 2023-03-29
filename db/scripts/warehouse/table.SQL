DROP TABLE IF EXISTS warehouse CASCADE;

CREATE TABLE IF NOT EXISTS warehouse (
    id SERIAL PRIMARY KEY NOT NULL,
    org_id TEXT NOT NULL,
    size_sqrt_m TEXT NULL,
    address TEXT NULL,
    photo_url_interrior TEXT,
    photo_url_exterrior TEXT,
    photo_url_por TEXT
)