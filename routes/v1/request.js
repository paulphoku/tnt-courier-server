var express = require("express");
var db = require("../../db");
var notify = require("../../notify");
var router = express.Router();


const do_add_request = async function (res, user_id, description, weight, price, destination_address, destination_lat, destination_lng, collection_address, collection_lat, collection_lng, reciever_name, reciever_cell, request_notes, schedule_time, polyline, addedondatetime) {
    db.query(`SELECT * FROM add_request($1,$2,$3,$4,$5,$6,$7,$8,$9,$10,$11,$12,$13,$14,$15, $16);`, [user_id, description, weight, price, destination_address, destination_lat, destination_lng, collection_address, collection_lat, collection_lng, reciever_name, reciever_cell, request_notes, schedule_time, polyline, addedondatetime], function (error, rows, fields) {
        if (error) {
            console.log(error)
        }
        if (rows && rows.rows.length > 0) {
            res.send({ msg: "Done", status: 0, data: { request_id: rows.rows[0].add_request } });
        } else {
            res.send({ status: 1, msg: 'Could not process request!' });
        }
    })


}

const do_get_request = async function (res, request_id) {
    db.query(`SELECT * FROM get_request($1);`, [request_id], function (error, rows, fields) {
        if (error) {
            console.log(error)
        }
        if (rows) {
            res.send({ msg: "Done", status: 0, data: rows.rows });
        } else {
            res.send({ status: 1, data: 'User not found!' });
        }
    })
}

const do_get_user_request = async function (res, user_id) {
    db.query(`SELECT * FROM get_request_user($1);`, [user_id], function (error, rows, fields) {
        if (error) {
            console.log(error)
        }
        if (rows) {
            res.send({ msg: "Done", status: 0, data: rows.rows });
        } else {
            res.send({ status: 1, data: 'User not found!' });
        }
    })
}

router.get("/:request_id", async function (req, res) {
    try {
        console.log('request_id', req.params.request_id)
        await do_get_request(
            res,
            req.params.request_id
        );
    } catch (err) {
        notify.sendError(res);
    }
});

router.get("/user/:user_id", async function (req, res) {
    try {
        console.log('user_id', req.params.user_id)
        await do_get_user_request(
            res,
            req.params.user_id
        );
    } catch (err) {
        notify.sendError(res);
    }
});

router.post("/", async function (req, res) {

    try {
        await do_add_request(
            res,
            req.body.user_id,
            req.body.description,
            req.body.weight,
            req.body.price,
            req.body.destination_address,
            req.body.destination_lat,
            req.body.destination_lng,
            req.body.collection_address,
            req.body.collection_lat,
            req.body.collection_lng,
            req.body.reciever_name,
            req.body.reciever_cell,
            req.body.request_notes,
            req.body.schedule_time,
            req.body.polyline,
            req.body.addedondatetime
        );
    } catch (err) {
        notify.sendError(res);
        console.log(err);
    }
});

module.exports = router;