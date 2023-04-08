--ADD transaction
DROP FUNCTION IF EXISTS add_transaction() CASCADE;
CREATE FUNCTION add_transaction (
    ref_id TEXT,
    amount FLOAT,
    currency TEXT,
    addedondatetime TIMESTAMP,
    status TEXT,
    method TEXT
) RETURNS TEXT AS $$
DECLARE created_id TEXT;
BEGIN
INSERT INTO transaction (
        ref_id,
        amount,
        currency,
        addedondatetime,
        status,
        method
    )
VALUES (
        add_transaction.ref_id,
        add_transaction.amount,
        add_transaction.currency,
        add_transaction.addedondatetime,
        add_transaction.status,
        add_transaction.method
    )
RETURNING id INTO created_id;
RETURN created_id;
END $$ LANGUAGE plpgsql;
/*
 
 SELECT  * FROM add_transaction(
 'ref_id',
 1.01,
 'currency',
 '2023-01-01 00:00:00',
 'status',
 'method'
 );
 */
-------------------END----------------------------------------------
--GET transaction BY user ID
DROP FUNCTION IF EXISTS get_transaction(user_id TEXT);
CREATE FUNCTION get_transaction(user_id TEXT) RETURNS TABLE (
    id INT,
    ref_id TEXT,
    amount FLOAT,
    currency TEXT,
    addedondatetime TIMESTAMP,
    status TEXT,
    method TEXT
) AS $$ BEGIN RETURN QUERY
SELECT t.id,
    t.ref_id,
    t.amount,
    t.currency,
    t.addedondatetime,
    t.status,
    t.method
FROM transaction t,
    t_user u,
    invoice i,
    request_customer rc,
    request r
WHERE rc.cust_id = u.uuid
    AND rc.requsest_id = r.id
    AND r.id = i.ref
    AND i.id = t.inv_no;
END $$ LANGUAGE plpgsql;
-- SELECT * FROM get_transaction('packed_by');
-------------------END----------------------------------------------
--GET transaction BY transaction_id
DROP FUNCTION IF EXISTS get_transaction(transaction_id INT);
CREATE FUNCTION get_transaction(transaction_id INT) RETURNS TABLE (
    id INT,
    ref_id TEXT,
    amount FLOAT,
    currency TEXT,
    addedondatetime TIMESTAMP,
    status TEXT,
    method TEXT
) AS $$ BEGIN RETURN QUERY
SELECT t.id,
    t.ref_id,
    t.amount,
    t.currency,
    t.addedondatetime,
    t.status,
    t.method
FROM transaction t
WHERE m.id = get_transaction.transaction_id;
END $$ LANGUAGE plpgsql;
-- SELECT * FROM get_transaction(1);
-------------------END----------------------------------------------
--GET ALL transaction
DROP FUNCTION IF EXISTS get_transaction();
CREATE FUNCTION get_transaction() RETURNS TABLE (
    id INT,
    ploc_id TEXT,
    date_created TIMESTAMP,
    packed_by TEXT
) AS $$ BEGIN RETURN QUERY
SELECT m.id,
    m.ploc_id,
    m.date_created,
    m.packed_by
FROM transaction m;
END $$ LANGUAGE plpgsql;
-- SELECT * FROM get_transaction();
-------------------END----------------------------------------------