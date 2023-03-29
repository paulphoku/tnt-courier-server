DROP TABLE IF EXISTS request CASCADE;

CREATE TABLE IF NOT EXISTS request (
    id SERIAL PRIMARY KEY NOT NULL,
    description TEXT NOT NULL,
    weight TEXT NULL,
    price TEXT NULL,
    destination_address TIMESTAMP NULL,
    destination_lat FLOAT NULL,
    destination_lng FLOAT NULL,
    collection_address TIMESTAMP NULL,
    collection_lat FLOAT NULL,
    collection_lng FLOAT NULL,
    reciever_name TEXT NULL,
    reciever_cell TEXT NULL,
    request_notes TEXT NULL,
    schedule_time TEXT NULL
)