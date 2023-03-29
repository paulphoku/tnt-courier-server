// This library connects to PostgreSQL and manages the connection pool.

// Create the PostgreSQL connection pool.
const conf = require("../conf");
const pg = require('pg');
const pool = new pg.Pool(conf.db_conf);

// Export it
module.exports = {
    async query(q, params, callback) {
        const client = await pool.connect()
        let res
        try {
            await client.query('BEGIN')
            try {
                res = client.query(q, params, callback)
                await client.query('COMMIT')
            } catch (err) {
                console.log('psql erro: ', err)
                await client.query('ROLLBACK')
                throw err
            }
        } finally {
            client.release()
        }
        return res
    }
};