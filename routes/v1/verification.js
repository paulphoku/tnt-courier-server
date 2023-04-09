var express = require("express");
var notify = require("../../notify");
var router = express.Router();
var sms = require('../../functions/sms');

const do_send_SMS = async function (res, tel, msg) {
    if (tel.length > 0) {
        sms.sendSMS(res, tel, msg);
        res.send({ msg: 'done', status: 0 })
    } else {
        res.send({ msg: 'Invalid tel', status: 0 })
    }
};

router.post("/sms", async function (req, res) {
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