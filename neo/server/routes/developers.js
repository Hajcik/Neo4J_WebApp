var express = require('express');
var neo4j = require('neo4j-driver')
var config = require('../config/dbData.json')
var router = express.Router();

var driver = neo4j.driver(config.dbHost, neo4j.auth.basic(config.dbUser, config.dbPass))
var session = driver.session()
var refresh = driver.session()

/* GET dev page. */
router.get('/', function(req, res) {
    refresh
        .run(`match ()-[r]->()
            match (s)-[r]->(e)
            with s,e,type(r) as typ, tail(collect(r)) as coll
            foreach(x in coll | delete x)`)
        .catch(function(err){
            console.log(err)
        })
        
    session
        .run('MATCH(d:Developer) RETURN(d)')
        .then(function(result){
            var devsArr = []
            result.records.forEach(function(record){
                devsArr.push({
                    id: record._fields[0].identity.low,
                    name: record._fields[0].properties.name,
                    country: record._fields[0].properties.country,
                    established: record._fields[0].properties.established
                })
            })
            res.render('developers', { title: 'Developers', devs: devsArr });
        })
        .catch(function(err){
            console.log(err)
        })
})

router.post('/newdev', function(req, res){
    session
        .run(`CREATE(m:Developer{
            name:'${req.body.name}', 
            country:'${req.body.country}',
            established:'${req.body.established}'})`)
        .then(function(result){
            res.redirect('back')
        })
        .catch(function(err){
            console.log(err)
        })
})

router.get('/delete', function(req, res){
    id = req.query.delete_id
     session
        .run(`MATCH(id) WHERE ID(id) = ${id} DELETE(id)`)
        .then(function(result){
            res.redirect('back')
        })
        .catch(function(err){
            console.log(err)
    })
})
module.exports = router;