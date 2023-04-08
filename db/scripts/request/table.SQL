DROP TABLE IF EXISTS request CASCADE;
CREATE TABLE IF NOT EXISTS request (
    id SERIAL PRIMARY KEY NOT NULL,
    request_id VARCHAR(100) GENERATED ALWAYS AS (generate_custom_id(id)) STORED,
    description TEXT NOT NULL,
    weight FLOAT NULL,
    price FLOAT NULL,
    destination_address TEXT NULL,
    destination_lat FLOAT NULL,
    destination_lng FLOAT NULL,
    collection_address TEXT NULL,
    collection_lat FLOAT NULL,
    collection_lng FLOAT NULL,
    reciever_name TEXT NULL,
    reciever_cell TEXT NULL,
    request_notes TEXT NULL,
    schedule_time TIMESTAMP,
    polyline TEXT
);