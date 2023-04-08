DROP TABLE IF EXISTS transaction CASCADE;
CREATE TABLE IF NOT EXISTS transaction (
    id SERIAL PRIMARY KEY NOT NULL,
    ref_id TEXT UNIQUE NOT NULL,
    amount FLOAT NOT NULL,
    currency TEXT NOT NULL,
    addedondatetime TIMESTAMP NOT NULL,
    status TEXT NULL,
    method TEXT
);