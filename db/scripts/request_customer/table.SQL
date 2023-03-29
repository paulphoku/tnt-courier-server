DROP TABLE IF EXISTS request_customer CASCADE;

CREATE TABLE IF NOT EXISTS request_customer (
    id SERIAL PRIMARY KEY NOT NULL,
    cust_id TEXT NOT NULL,
    requsest_id TEXT NULL,
    request_status	TEXT NULL,
    addedondatetime TIMESTAMP NULL
)