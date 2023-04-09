var conf = require('../../conf');
const Twilio = require("twilio");

// getting ready
const client = Twilio(conf.twillio.accountSid, conf.twillio.authToken);

// Validate E164 format
function validE164(num) {
    return /^\+?[1-9]\d{1,14}$/.test(num)
}

module.exports = {
    sendSMS: async (res, tel, message) => {

        // start sending message
        const phoneNumbers = [tel];

        phoneNumbers.map(phoneNumber => {

            if (!validE164(phoneNumber)) {
                // res.send({
                //     status: 1,
                //     msg: "number must be E164 format!"
                // });
                throw new Error('number must be E164 format!');
            }

            const textContent = {
                body: message,
                to: phoneNumber,
                from: conf.twillio.twilioNumber,
                // messagingServiceSid: conf.twillio.messagingServiceSid
            }
            client.messages.create(textContent)
                .then((message) => {
                    console.log(message);
                    //success msg here
                    return message;
                }).catch(err => {
                    //error msg here
                })
        })
    }
}