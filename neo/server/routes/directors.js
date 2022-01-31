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
        .run('MATCH(d:Director) RETURN(d)')
        .then(function(result){
            var dirsArr = []
            result.records.forEach(function(record){
                dirsArr.push({
                    id: record._fields[0].identity.low,
                    name: record._fields[0].properties.name
                })
            })
            res.render('directors', { title: 'Directors', dirs: dirsArr });
        })
        .catch(function(err){
            console.log(err)
        })
})

// Add new
router.post('/newdir', function(req, res){
    var name = req.body.name
    session
        .run(`CREATE(d:Director{name:'${name}'})`)
        .then(function(result){
            res.redirect('back')
        })
        .catch(function(err){
            console.log(err)
        })
})

// Delete selected
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