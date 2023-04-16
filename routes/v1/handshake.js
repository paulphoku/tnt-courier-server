//this api does nothing but sends back an emoji of a handshake , you are welcome What does 🤭!

var express = require("express");
var notify = require("../../notify");
var router = express.Router();

const do_handshake = async function (res) {
    res.send({ msg: "Done", status: 0, data: '🤝' });
}

router.get("/", async function (req, res) {
    try {
        await do_handshake(
            res
        );
    } catch (err) {
        notify.sendError(res);
    }
});

module.exports = router;