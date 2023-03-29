DROP TABLE IF EXISTS transaction CASCADE;

CREATE TABLE IF NOT EXISTS transaction (
    id SERIAL PRIMARY KEY NOT NULL,
    ref_id TEXT UNIQUE NOT NULL,
    amount FLOAT NULL,
    currency TEXT NULL,
    addedondatetime TIMESTAMP NULL,
    status TEXT NULL
)