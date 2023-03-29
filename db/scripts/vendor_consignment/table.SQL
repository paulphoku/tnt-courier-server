DROP TABLE IF EXISTS vendor_consignment CASCADE;

CREATE TABLE IF NOT EXISTS vendor_consignment (
    id SERIAL PRIMARY KEY NOT NULL,
    ref TEXT NOT NULL,
    vendor_id TEXT NULL,
    notes TEXT NULL,
    qty FLOAT NULL,
    notes TEXT NULL,
    photo_url TEXT NULL,
    date_created TIMESTAMP NULL,
    destination_addr TEXT NULL,
    destination_lat FLOAT NULL,
    destination_lng FLOAT NULL,
    destination_state TEXT NULL,
    destination_city TEXT NULL
)