var express = require('express');
var neo4j = require('neo4j-driver')
var config = require('../config/dbData.json')
var router = express.Router();

var driver = neo4j.driver(config.dbHost, neo4j.auth.basic(config.dbUser, config.dbPass))
var session = driver.session()
var refresh = driver.session()

// Get mod page
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
        .run('MATCH(m:Mod) RETURN (m)')
        .then(function(result){
            var modsArr = []
            result.records.forEach(function(record){
                modsArr.push({
                    id: record._fields[0].identity.low,
                    title: record._fields[0].properties.title,
                    moddedGame: record._fields[0].properties.moddedGame,
                    director: record._fields[0].properties.director,
                    publisher: record._fields[0].properties.publisher
                })
            })
            res.render('mods', { title: 'Mods', mods: modsArr })
        })
        .catch(function(err){
            console.log(err)
        })
})

router.post('/newmod', function(req, res){
    session
        .run(`CREATE(m:Mod{
            title:'${req.body.title}', 
            moddedGame:'${req.body.moddedGame}',
            director:'${req.body.director}',
            publisher:'${req.body.publisher}'})`)
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