var express = require("express");
var db = require("../../functions/db/index");
var notify = require("../../notify");
var moment = require("moment");
const util = require('util');
var router = express.Router();
var uuid = require('uuid');
var payment = require('../../functions/payments/paystack')

var emailer = require('../../functions/email');

// node native promisify
const query = util.promisify(db.query).bind(db);

// node native promisify

const do_get_transactions = async function (res, user_id) {
    // res.send(await transactions.get_transactions(user_id))
};

const do_add_transaction = async function (res, transaction_id, sitename) {
    //verify transaction 
    let transaction = await payment.transaction.verify(transaction_id, sitename);
    let amount = payment.converter.kobo_to_zar(transaction.data.amount)
    let email = transaction.data.customer.email;
    let addedondatetime = transaction.data.transaction_date;

    // let user_id = (await user.get_user(email)).rows[0].user_id;
    // let balance = (await transactions.get_balance(user_id));
    // let newBalance = Number(balance) + Number(amount);

    let description = `Money in + `
    if (transaction.message == 'Verification successful') {
        //positive response
        res.render('success', {
            title: 'Transaction succesful!',
            message: `
             Your credits should reflect soon on ${sitename}
            `
        })

        //record on db
        // transactions.add_transaction(amount, email, addedondatetime, description, transaction_id, sitename)
    } else {
        let error = {
            status: 'Error'
        }
        res.render('error', {
            error: error,
            message: transaction.message,
        })
    }
};


const do_init_transaction = async function (res, email, amount, sitename) {
    //verify transaction 
    console.log({
        email: email,
        amount: amount,
        sitename: sitename
    })
    let transaction = await payment.transaction.Initialize(email, amount, sitename)
    res.send(transaction)
};

const do_add_customer = async function (res, email, fname, lname, phone) {
    let customer = await payment.customer.create(email, fname, lname, phone);
    res.send(customer);
};

router.post("/request", async function (req, res) {
    try {
        await do_init_transaction(
            res,
            req.body.email,
            req.body.amount,
            req.body.sitename
        );
    } catch (err) {
        console.log('Error: ', err)
        notify.sendError(res);
    }
});

router.get("/add/:sitename", async function (req, res) {
    try {
        await do_add_transaction(
            res,
            req.query.reference,
            req.params.sitename
        );
    } catch (err) {
        console.log('Error: ', err)
        notify.sendError(res);
    }
});

router.post("/user", async function (req, res) {
    try {
        await do_get_transactions(
            res,
            req.body.user_id
        );
    } catch (err) {
        console.log('Error: ', err)
        notify.sendError(res);
    }
});

router.post("/add_customer", async function (req, res) {
    try {
        await do_add_customer(
            res,
            req.body.email,
            req.body.fname,
            req.body.lname,
            req.body.phone
        );
    } catch (err) {
        console.log('Error: ', err)
        notify.sendError(res);
    }
});



module.exports = router;