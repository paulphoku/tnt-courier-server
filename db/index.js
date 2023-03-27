// This library connects to PostgreSQL and manages the connection pool.

// Create the PostgreSQL connection pool.
const mysql = require("mysql");
const conf = require("../conf/");
//const query =  Pool.createConnection(conf.db_conf);
var db = mysql.createPool(conf.db_conf);

db.getConnection((err, connection) => {
    if (err) {
        if (err.code === 'PROTOCOL_CONNECTION_LOST') {
            console.error('Database connection was closed.')
        }
        if (err.code === 'ER_CON_COUNT_ERROR') {
            console.error('Database has too many connections.')
        }
        if (err.code === 'ECONNREFUSED') {
            console.error('Database connection was refused.')
        }
    }
    if (connection){
        connection.release();
        console.log(conf.db_conf.database);
    }
    return
})

// Export it
module.exports = db;

