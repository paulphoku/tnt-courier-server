DROP TABLE IF EXISTS vehicle_driver CASCADE;

CREATE TABLE IF NOT EXISTS vehicle_driver (
    id SERIAL PRIMARY KEY NOT NULL,
    driver_id TEXT NOT NULL,
    vehicle_id TEXT NULL
)