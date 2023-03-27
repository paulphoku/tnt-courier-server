var express = require("express");
var notify = require("../../notify");
var router = express.Router();
var conf = require("../../conf")

const request = require('request');
const util = require('util');
const { json } = require("body-parser");
const requestPromise = util.promisify(request);

const do_get_places = async function (res, input) {
    var location = [];
    var places = [];
    const response = await requestPromise(`https://maps.googleapis.com/maps/api/place/autocomplete/json?key=${conf.googleMaps.key}&input=${input}&components=country:za`);

    predictions = await JSON.parse(response.body).predictions;

    // console.log(input);
    for (let index = 0; index < predictions.length; index++) {
        let place = predictions[index].description;
        let structured_formatting = predictions[index].structured_formatting.main_text;
        const resp = await requestPromise(`https://maps.googleapis.com/maps/api/geocode/json?key=${conf.googleMaps.key}&address=${place}`);
        let results = await JSON.parse(resp.body);

        if (results) {
            places.push({ description: place, location: results.results[0].geometry.location, structured_formatting: structured_formatting });
        }

        if (index + 1 == predictions.length) {
            res.send(places);
        }
    }

};

const do_get_places_nearby = async function (res, input) {
    var location = [];
    var places = [];
    const response = await requestPromise(`https://maps.googleapis.com/maps/api/place/autocomplete/json?key=${conf.googleMaps.key}&input=${input}&components=country:za`);

    predictions = await JSON.parse(response.body).predictions;

    // console.log(input);
    for (let index = 0; index < predictions.length; index++) {
        let place = predictions[index].description;
        let structured_formatting = predictions[index].structured_formatting.main_text;
        const resp = await requestPromise(`https://maps.googleapis.com/maps/api/geocode/json?key=${conf.googleMaps.key}&address=${place}`);
        let results = await JSON.parse(resp.body);

        if (results) {
            places.push({ description: place, location: results.results[0].geometry.location, structured_formatting: structured_formatting });
        }

        if (index + 1 == predictions.length) {
            res.send(places);
        }
    }

};

const do_get_directions = async function (res, origin, destination) {

    request(`https://maps.googleapis.com/maps/api/directions/json?key=${conf.googleMaps.key}&origin=${origin}&destination=${destination}`, { json: true }, (err, res1, body) => {
        if (err) { return console.log(err); }

        let points = polyline.decode(body.routes[0].overview_polyline.points);
        //console.log(points);
        let path = [];
        let bounds = [];
        let distance = 0;

        //restriction bounds on map
        bounds.push(body.routes[0].bounds.northeast);
        bounds.push(body.routes[0].bounds.southwest);

        //path / points on map
        for (let k = 0; k < points.length; k++) {
            let x = String(points[k]).split(',');
            //console.log({lat: Number(x[0]), lng:Number(x[1])})
            path.push({ lat: Number(x[0]), lng: Number(x[1]) });
        }

        //Travelling distance
        distance = body.routes[0].legs[0].distance.value;
        //convert to km
        distance = distance / 1000;

        db.query("SELECT description, fare_p_min, fare_per_km , usage_desc FROM vehicle_type", [], async function (error, rows, fields) {
            let vehicle = [];
            for (let k = 0; k < rows.length; k++) {
                vehicle.push({
                    description: rows[k].description,
                    fare_p_min: rows[k].fare_p_min,
                    fare_per_km: rows[k].fare_per_km,
                    fare: Math.round(Number(rows[k].fare_per_km) * distance)/**Rounded off to whole number */,
                    usage: rows[k].usage_desc
                })
            }
            //send data
            res.send({
                path: path, bounds: bounds, distance: distance, vehicle
            })
        })


    });
};

router.post("/places", async function (req, res) {
    try {
        await do_get_places(
            res,
            req.body.input
        );
    } catch (err) {
        notify.sendError(res);
        console.log(err);
    }
});

router.post("/directions", async function (req, res) {
    try {
        await do_get_directions(
            res,
            req.body.origin,
            req.body.destination
        );
    } catch (err) {
        notify.sendError(res);
        console.log(err);
    }
});

router.post("/places-nearby", async function (req, res) {
    try {
        await do_get_places_nearby(
            res,
            req.body.origin
        );
    } catch (err) {
        notify.sendError(res);
        console.log(err);
    }
});

module.exports = router;