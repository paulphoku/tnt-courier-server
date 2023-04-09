var express = require("express");
var notify = require("../notify");
var router = express.Router();
var sms = require('../functions/send_sms');

const do_send_SMS = async function (res, tel, msg) {
    if (tel.length > 0) {
        res.send({ msg: 'Cellphone Number already registered! Proceed to login', status: 1 });
        console.log(rows);
    } else {
        sms.sendSMS(res, tel, msg);
        res.send({ msg: 'done', status: 0 })
    }
};

router.get("/", async function (req, res) {
    try {
        await do_send_SMS(
            res,
            req.params.tel,
            req.params.msg
        );
    } catch (err) {
        notify.sendError(res);
    }
});

router.post("/", async function (req, res) {
    try {
        await do_send_SMS(
            res,
            req.body.tel,
            req.body.msg
        );
    } catch (err) {
        notify.sendError(res);
        console.log(err);
    }
});

module.exports = router;