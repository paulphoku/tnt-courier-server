DROP TABLE IF EXISTS invoice CASCADE;
CREATE TABLE IF NOT EXISTS invoice (
    id SERIAL PRIMARY KEY NOT NULL,
    ref TEXT NOT NULL,
    t_id TEXT NOT NULL,
    weight FLOAT,
    height FLOAT,
    length FLOAT,
    width FLOAT,
    date_created TIMESTAMP NOT NULL,
    status TEXT,
    amount FLOAT
);