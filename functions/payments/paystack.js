var conf = require('../../conf/index');
const https = require('https');

var config = {
    options: {
        hostname: conf.PayStack.host,
        port: 443,
        path: '/',
        method: 'POST',
        headers: {
            Authorization: `Bearer ${conf.PayStack.APIKEY.novopay.test}`,
            'Content-Type': 'application/json'
        }
    },
    host: conf.PayStack.host,
};

var converter = {
    zar_to_kobo: function (amt) {
        return (amt * 100).toFixed(2);
    },

    kobo_to_zar: function (amt) {
        return (amt / 100).toFixed(2);
    }
}

var constructor = {
    /**
      * 
      * initialise sitename api key
      * 
      * @param sitename sitename requesting : ('sitelive', 'novopay')
      */
    init_key: function (sitename) {
        switch (sitename) {
            case 'sitelive':
                config.options.headers.Authorization = `Bearer ${conf.PayStack.APIKEY.sitelive.test}`
                break;
            case 'novopay':
                config.options.headers.Authorization = `Bearer ${conf.PayStack.APIKEY.novopay.test}`
                break;
            default:
                config.options.headers.Authorization = `Bearer ${conf.PayStack.APIKEY.novopay.test}`
                break;
        }
    }
}

var customer = {
    /**
        * 
        * initialise a customer to the platform
        * 
        * @param email customers email 
        * @param first_name optional !
        * @param last_name optional !
        * @param phone optional ! (e.g +277842929337) 
        */
    create: async function (email, first_name, last_name, phone, sitename) {
        return new Promise((resolve, reject) => {
            config.options.method = 'POST';
            config.options.path = `/customer`;

            const params = JSON.stringify({
                "email": email,
                "first_name": first_name,
                "last_name": last_name,
                "phone": phone
            })

            const req = https.request(config.options, res => {
                let data = ''
                res.on('data', (chunk) => {
                    data += chunk
                });
                res.on('end', () => {
                    // console.log(JSON.parse(data))
                    resolve(JSON.parse(data));
                })
            }).on('error', error => {
                console.error(error)
            })
            req.write(params)
            req.end()
        })
    },

    /**
     * 
     * List customers available on your integration.
     * 
     * @param perPage optional ! : Specify how many records you want to retrieve per page. If not specify we use a default value of 50.
     * @param page optional ! : Specify exactly what page you want to retrieve. If not specify we use a default value of 1.
     */
    list: async function (perPage, page, sitename) {
        return new Promise((resolve, reject) => {
            config.options.method = 'GET';
            config.options.path = `/customer`;

            const params = JSON.stringify({
                "perPage": perPage,
                "page": page
            })

            const req = https.request(config.options, res => {
                let data = ''
                res.on('data', (chunk) => {
                    data += chunk
                });
                res.on('end', () => {
                    // console.log(JSON.parse(data))
                    resolve(JSON.parse(data));
                })
            }).on('error', error => {
                console.error(error)
            })
            req.write(params)
            req.end()
        })
    },

    /**
      * 
      * Get details of a customer on your integration.
      * @param customer_id :email_or_code
      * 
      */
    get: async function (customer_id, sitename) {
        return new Promise((resolve, reject) => {
            config.options.method = 'GET';
            config.options.path = `/customer/${customer_id}`;

            const params = JSON.stringify({
            })

            const req = https.request(config.options, res => {
                let data = ''
                res.on('data', (chunk) => {
                    data += chunk
                });
                res.on('end', () => {
                    // console.log(JSON.parse(data))
                    resolve(JSON.parse(data));
                })
            }).on('error', error => {
                console.error(error)
            })
            req.write(params)
            req.end()
        })
    },

    /**
      * 
      * Update a customer's details on your integration
      * @param customer_code customer code on your intergration 
      * @param email customers email 
      * @param first_name optional !
      * @param last_name optional !
      * @param phone optional ! (e.g +277842929337)        
      */
    update: async function (customer_code, email, first_name, last_name, phone, sitename) {
        return new Promise((resolve, reject) => {
            config.options.method = 'PUT';
            config.options.path = `/customer/${customer_code}`;

            const params = JSON.stringify({
                "email": email,
                "first_name": first_name,
                "last_name": last_name,
                "phone": phone
            })

            const req = https.request(config.options, res => {
                let data = ''
                res.on('data', (chunk) => {
                    data += chunk
                });
                res.on('end', () => {
                    // console.log(JSON.parse(data))
                    resolve(JSON.parse(data));
                })
            }).on('error', error => {
                console.error(error)
            })
            req.write(params)
            req.end()
        })
    }
}

var transaction = {
    /**
    * 
    * initialise a transation with a customer
    * 
    * @param email customers email
    * @param amount amount to charge
    * 
    * @param callback_url Optional
    */
    Initialize: async function (email, amount, sitename) {
        return new Promise((resolve, reject) => {
            constructor.init_key(sitename);
            config.options.method = 'POST';
            config.options.path = `/transaction/initialize`;

            const params = JSON.stringify({
                "email": email,
                "amount": converter.zar_to_kobo(amount),
                "callback_url": `${conf._server_url}/v1/transactions/add/${sitename}`
            })

            const req = https.request(config.options, res => {
                let data = ''
                res.on('data', (chunk) => {
                    data += chunk
                });
                res.on('end', () => {
                    // console.log(JSON.parse(data))
                    resolve(JSON.parse(data));
                })
            }).on('error', error => {
                console.error(error)
            })
            req.write(params)
            req.end()
        })
    },

    /**
    * 
    * Confirm the status of a transaction
    * 
    * @param reference The transaction reference used to intiate the transaction
    */
    verify: async function (reference, sitename) {
        return new Promise((resolve, reject) => {
            config.options.method = 'GET';
            config.options.path = `/transaction/verify/${reference}`;

            constructor.init_key(sitename);

            const req = https.request(config.options, res => {
                let data = ''
                res.on('data', (chunk) => {
                    data += chunk
                });
                res.on('end', () => {
                    // console.log(JSON.parse(data))
                    resolve(JSON.parse(data));
                })
            }).on('error', error => {
                console.error(error)
            })
            req.write('')
            req.end()
        })
    },

    /**
    * 
    * List transactions carried out on your integration.
    * 
    * @param perPage optional ! : Specify how many records you want to retrieve per page. If not specify we use a default value of 50.
    * @param page optional ! : pecify exactly what page you want to retrieve. If not specify we use a default value of 1.
    */
    list: async function (perPage, page) {
        return new Promise((resolve, reject) => {
            config.options.method = 'GET';
            config.options.path = `/transaction`;

            constructor.init_key(sitename);

            const params = JSON.stringify({
                "perPage": perPage,
                "page": page
            })

            const req = https.request(config.options, res => {
                let data = ''
                res.on('data', (chunk) => {
                    data += chunk
                });
                res.on('end', () => {
                    // console.log(JSON.parse(data))
                    resolve(JSON.parse(data));
                })
            }).on('error', error => {
                console.error(error)
            })
            req.write(params)
            req.end()
        })
    },

    /**
    * 
    * Get details of a transaction carried out on your integration.
    * 
    * @param id : number , A transaction id for the transaction to fetch
    */
    get: async function (id) {
        return new Promise((resolve, reject) => {
            config.options.method = 'GET';
            config.options.path = `/transaction/${id}`;

            constructor.init_key(sitename);

            const req = https.request(config.options, res => {
                let data = ''
                res.on('data', (chunk) => {
                    data += chunk
                });
                res.on('end', () => {
                    // console.log(JSON.parse(data))
                    resolve(JSON.parse(data));
                })
            }).on('error', error => {
                console.error(error)
            })
            req.write('')
            req.end()
        })
    },
}

var invoice = {
    /**
       * 
       * initialise a customer to the platform
       * 
       * @param description invoive description
       * @param line_items 
       * @param customer customer code
       * @param due_date 
       */
    create: async function (description, line_items, customer, due_date) {
        return new Promise((resolve, reject) => {
            config.options.method = 'POST';
            config.options.path = `/paymentrequest`;

            constructor.init_key(sitename);

            const params = JSON.stringify({
                "description": "a test invoice",
                "line_items": [
                    { "name": "item 1", "amount": 20000 },
                    { "name": "item 2", "amount": 20000 }
                ],
                "tax": [
                    { "name": "VAT", "amount": 2000 }
                ],
                "customer": "CUS_005nvgt3i3w20z8",
                "due_date": "2020-07-08"
            })

            const req = https.request(config.options, res => {
                let data = ''
                res.on('data', (chunk) => {
                    data += chunk
                });
                res.on('end', () => {
                    // console.log(JSON.parse(data))
                    resolve(JSON.parse(data));
                })
            }).on('error', error => {
                console.error(error)
            })
            req.write(params)
            req.end()
        })
    },
}


module.exports = {
    customer: customer,
    transaction: transaction,
    converter: converter,
    invoice: invoice
}
