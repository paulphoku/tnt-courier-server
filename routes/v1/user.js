var express = require("express");
var db = require("../db");
var notify = require("../notify");
var router = express.Router();

const do_get_all_user = async function (res, search, SortBy, filterBy) {

    db.query("Select uuid, user_role, names, DATE_FORMAT(datecreated,'%Y-%b-%d  %H:%i') as datecreated, surname, contact, email, address, description AS gender, photourl, dateofbirth From user , gender WHERE (user.gender = gender.id) AND (user.email like '%" + search + "%' OR user.names like '%" + search + "%' OR user.surname like '%" + search + "%') ORDER BY  "+filterBy+" "+SortBy+"", [ ], function (error, rows, fields) {
        if (error) {
            console.log(error)
        }
        res.send({ msg: "Done", status: 0, rows: rows.length, data: rows });
    })
};

router.get("/:", async function (req, res) {
    try {
        await do_get_all_user(
            res,
            req.params.search,
            req.params.SortBy,
            req.params.filterBy
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