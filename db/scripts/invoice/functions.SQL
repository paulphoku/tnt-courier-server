--ADD invoice
DROP FUNCTION IF EXISTS add_invoice();
CREATE FUNCTION add_invoice (
    ref TEXT,
    weight FLOAT,
    height FLOAT,
    length FLOAT,
    width FLOAT,
    date_created TIMESTAMP,
    status TEXT,
    amount FLOAT
) RETURNS TEXT AS $$
DECLARE created_id TEXT;
BEGIN
INSERT INTO invoice (
        ref,
        weight,
        height,
        length,
        width,
        date_created,
        status,
        amount
    )
VALUES (
        add_invoice.ref,
        add_invoice.weight,
        add_invoice.height,
        add_invoice.length,
        add_invoice.width,
        add_invoice.date_created,
        add_invoice.status,
        add_invoice.amount
    )
RETURNING id INTO created_id;
RETURN created_id;
END $$ LANGUAGE plpgsql;
/*
 
 SELECT  * FROM add_invoice(
 'ref',
 1,
 1,
 1,
 1,
 '2023-01-01 00:00:00',
 'status',
 0.00
 );
 */
-------------------END----------------------------------------------
--GET invoice BY ID
DROP FUNCTION IF EXISTS get_invoice(invoice_id INT);
CREATE FUNCTION get_invoice(invoice_id INT) RETURNS TABLE (
    id INT,
    ref TEXT,
    weight FLOAT,
    height FLOAT,
    length FLOAT,
    width FLOAT,
    date_created TIMESTAMP,
    status TEXT,
    amount FLOAT
) AS $$ BEGIN RETURN QUERY
SELECT i.id,
    i.ref,
    i.weight,
    i.height,
    i.length,
    i.width,
    i.date_created,
    i.status,
    i.amount
FROM invoice i
WHERE i.id = get_invoice.invoice_id;
END $$ LANGUAGE plpgsql;
-- SELECT * FROM get_invoice(1);
-------------------END----------------------------------------------
--GET ALL INVOICE
DROP FUNCTION IF EXISTS get_invoice();
CREATE FUNCTION get_invoice() RETURNS TABLE (
    id INT,
    ref TEXT,
    weight FLOAT,
    height FLOAT,
    length FLOAT,
    width FLOAT,
    date_created TIMESTAMP,
    status TEXT,
    amount FLOAT
) AS $$ BEGIN RETURN QUERY
SELECT i.id,
    i.ref,
    i.weight,
    i.height,
    i.length,
    i.width,
    i.date_created,
    i.status,
    i.amount
FROM invoice i;
END $$ LANGUAGE plpgsql;
-- SELECT * FROM get_invoice();
-------------------END----------------------------------------------