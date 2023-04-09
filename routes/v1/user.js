var express = require("express");
var db = require("../../db");
var notify = require("../../notify");
var router = express.Router();

const do_get_all_user = async function (res, search, SortBy, filterBy) {

    db.query("SELECT * FROM get_user();", [], function (error, rows, fields) {
        if (error) {
            console.log(error)
        }
        res.send({ msg: "Done", status: 0, rows: rows.length, data: rows.rows });
    })
};

const do_get_user = async function (res, user_id) {
    db.query(`SELECT * FROM get_user('${user_id}');`, [], function (error, rows, fields) {
        if (error) {
            console.log(error)
        }
        res.send({ msg: "Done", status: 0, rows: rows.length, data: rows.rows });
    })
}

router.get("/:user_id", async function (req, res) {
    try {
        // console.log({user_id:req.params.user_id})
        await do_get_user(
            res,
            req.params.user_id
        );
    } catch (err) {
        notify.sendError(res);
    }
});

router.post("/", async function (req, res) {
    try {
        await do_get_all_user(
            res,
            req.body.search,
            req.body.SortBy,
            req.body.filterBy
        );
    } catch (err) {
        notify.sendError(res);
        console.log(err);
    }
});

module.exports = router;