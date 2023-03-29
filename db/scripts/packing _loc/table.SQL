DROP TABLE IF EXISTS org_user CASCADE;

CREATE TABLE IF NOT EXISTS org_user (
    id SERIAL PRIMARY KEY NOT NULL,
    w_id TEXT NOT NULL,
    packed_by TEXT NULL,
    shipment_id TEXT NULL,
    qty FLOAT NULL,
    notes TEXT NULL,
    photo_url TEXT NULL,
    date_created TIMESTAMP NULL
)