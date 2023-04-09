// This exports variables required to connect to the database
module.exports = {
    // ----[ Database ]----------------------------------------------------------------


    // This connects to the postgres.render server
    // db_conf: {
    //     user: "postgres",
    //     host: "localhost",
    //     database: "tntc.main",
    //     password: "postgres",
    //     port: 5432,
    //     ssl: false
    // },

    // This connects to the local server
    db_conf: {
        user: "postgres",
        host: "localhost",
        database: "tntc.main",
        password: "Push2life@",
        port: 5432,
        ssl: false
    },

     //this connects to sms service
     twillio: {
        twilioNumber: '+15075955823',
        accountSid: 'ACb43150568429fac3440ea1cc0c177e9a',
        authToken: '04fab8194dc8ac3d86f5d15dcf47d82a',
        messagingServiceSid: 'MGed1c2df7507d0168400b2ca4ef89f238'
    },

    googleMaps:{
        key:'AIzaSyAr7NikHspaxjGJ7vj-MvAXhdxwJWmG6SU'
    },

    firebase: {
        sitelive: {
            apiKey: "AIzaSyCeHmhn9RPt9o31n57W8fzsoeNno297aNE",
            authDomain: "sitelive-905d1.firebaseapp.com",
            databaseURL: "https://sitelive-905d1-default-rtdb.firebaseio.com",
            projectId: "sitelive-905d1",
            storageBucket: "sitelive-905d1.appspot.com",
            messagingSenderId: "944042800670",
            appId: "1:944042800670:web:7094935021ba9d3809e00f",
            measurementId: "G-JYRJQ0932C"
        }

    },

    // _server_url: 'http://localhost:3000', //test
    _server_url: 'https://novopay.onrender.com', //live

    // ----[ Mail ]--------------------------------------------------------------------

    // Mail connection configuration
    //this connects to email server
    smtp: {
        host: "mail.vizn.africa",
        port: 465,
        auth: {
            user: 'lmc.app@vizn.africa',
            pass: 'DEPY=qPxZm8='
        },
        tls: true,
    },

    // ----[ Authentication cookies ]--------------------------------------------------

    auth: {
        // Duration, in seconds, that the various authorisation cookies are valid
        api_duration: 1800,


        // Refresh interval, in seconds, after which an authorisation cookie is refreshed
        api_refresh: 900,


        // Cookie secrets
        secrets: {
            api: "gr2GWbxv5W3d0sDzV7HgT74hYD3nb2byL0X6hs1HWzLj6n8dR93J8zmKfFzbl78Gt9R1qxYqjz6kKD4nQr8MPd34slhQlQHQxm06ZWS5JxV5ThbVw9xjY23WlRYYqVgf30KHx9bKBs6Tzx1"

        }
    },

    // ----[ Ports ]-------------------------------------------------------------------

    ports: {
        ip: 33343,
        api: 9023,
        pay: 8080,

    },

    // ----[ Payment ]
    PayStack: {
        APIKEY: {
            sitelive:
            {
                live: 'pk_test_0ad954c46b753ceddf9f7913e2dd47322e5cbdd4',
                test: 'sk_test_e29cbf8283bec37bd0c9ce472ab851e437462f35',
            },
            novopay:
            {
                live: 'sk_live_c9b6a851287f7300bc5dfd2c275ba36e1102b325',
                test: 'sk_test_fe4b8c10dee7f995ac7335727fb62f82b9f24400',
            },
        },
        host: 'api.paystack.co'
    }

};