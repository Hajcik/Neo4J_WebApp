var express = require('express');
var neo4j = require('neo4j-driver')
var config = require('../config/dbData.json')
var router = express.Router();

var driver = neo4j.driver(config.dbHost, neo4j.auth.basic(config.dbUser, config.dbPass))
var session = driver.session()
var refresh = driver.session()

/* GET home page. */
router.get('/', function(req, res) {
    session
        .run('MATCH(g:Game) RETURN (g)')
        .then(function(result){
            var gamesArr = []
            result.records.forEach(function(record){
                gamesArr.push({
                    id: record._fields[0].identity.low,
                    title: record._fields[0].properties.title,
                    genre: record._fields[0].properties.genre,
                    price: record._fields[0].properties.price,
                    publisher: record._fields[0].properties.publisher,
                    developer: record._fields[0].properties.developer,
                    director: record._fields[0].properties.director
                })
            })
            res.render('games', { title: 'Games', games: gamesArr })
        })
        .catch(function(err){
            console.log(err)
    })
    refresh
        .run(`match ()-[r]->()
            match (s)-[r]->(e)
            with s,e,type(r) as typ, tail(collect(r)) as coll
            foreach(x in coll | delete x)`)
        .catch(function(err){
            console.log(err)
        })
})

router.post('/newgame', function(req, res){
    session
        .run(`CREATE(m:Game{
            title:'${req.body.title}', 
            genre:'${req.body.genre}',
            developer:'${req.body.developer}',
            publisher:'${req.body.publisher}',
            price:'${req.body.price}'})`)
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
