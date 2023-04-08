-- Database: tntc.main
-- DROP DATABASE IF EXISTS "tntc.main";
CREATE DATABASE "tntc.main" WITH OWNER = postgres ENCODING = 'UTF8' LC_COLLATE = 'English_South Africa.1252' LC_CTYPE = 'English_South Africa.1252' TABLESPACE = pg_default CONNECTION
LIMIT = -1 IS_TEMPLATE = False;
--uuid generator
CREATE EXTENSION IF NOT EXISTS "uuid-ossp";
--custom id
DROP FUNCTION IF EXISTS  generate_custom_id(id INT) CASCADE;
CREATE FUNCTION generate_custom_id(id INT) returns text as $$
SELECT 'T' || TO_CHAR(now(), 'YY') || TO_CHAR(id, 'FM000000');
$$ language sql immutable;
-- ????
CREATE SEQUENCE customers_seq;