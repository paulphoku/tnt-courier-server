var express = require("express");
var db = require("../../db");
var notify = require("../../notify");
var router = express.Router();

const do_add_user = async function (res, user_role, address, id_no, contact, email, country, state, datecreated, modifiedondatetime, password, salt, gender, names, surname, photourl, username, dob) {

    db.query(`SELECT  * FROM add_user($1,$2,$3,$4,$5,$6,$7,$8,$9,$10,$11,$12,$13,$14,$15,$16,$17); `, [user_role, address, id_no, contact, email, country, state, datecreated, modifiedondatetime, password, salt, gender, names, surname, photourl, username,
        dob], function (error, rows, fields) {
            if (error) {
                console.log(error)
            }
            if (rows.add_user && rows.add_user != -1) {
                res.send({ msg: "Done", status: 0, data: rows.add_user });
            } else {
                res.send({ status: 1, data: 'email or cantact already exists!' });
            }
        })
};

const do_get_user = async function (res, user_id) {
    db.query(`SELECT * FROM get_user($1);`, [user_id], function (error, rows, fields) {
        if (error) {
            console.log(error)
        }
        if (rows.rows && rows.rows.length > 0) {
            res.send({ msg: "Done", status: 0, data: rows.rows });
        } else {
            res.send({ status: 1, data: 'User not found!' });
        }
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
    console.log('datecreated', req.body.datecreated)

    try {
        await do_add_user(
            res,
            req.body.user_role,
            req.body.address,
            req.body.id_no,
            req.body.contact,
            req.body.email,
            req.body.country,
            req.body.state,
            req.body.datecreated,
            req.body.modifiedondatetime,
            req.body.password,
            req.body.salt,
            req.body.gender,
            req.body.names,
            req.body.surname,
            req.body.photourl,
            req.body.username,
            req.body.dob
        );
    } catch (err) {
        notify.sendError(res);
        console.log(err);
    }
});

module.exports = router;