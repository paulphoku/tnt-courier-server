DROP TABLE IF EXISTS status CASCADE;
CREATE TABLE IF NOT EXISTS status (
    id SERIAL PRIMARY KEY NOT NULL,
    char_code TEXT UNIQUE NOT NULL,
    description TEXT NOT NULL
);
INSERT INTO public.status(char_code, description)
VALUES ('t', 'table'),
    ('p', 'pending'),
    ('c', 'complete'),
    ('dc', 'driver cancelled'),
    ('cc', 'customer cancelled'),
    ('s', 'stock');