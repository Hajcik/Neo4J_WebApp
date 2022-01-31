var express = require('express');
var neo4j = require('neo4j-driver')
var config = require('../config/dbData.json')
var router = express.Router();

var driver = neo4j.driver(config.dbHost, neo4j.auth.basic(config.dbUser, config.dbPass))
var session = driver.session()
var refresh = driver.session()

/* GET home page. */
router.get('/', function(req, res, next) {
    refresh
        .run(`match ()-[r]->()
            match (s)-[r]->(e)
            with s,e,type(r) as typ, tail(collect(r)) as coll
            foreach(x in coll | delete x)`)
        .catch(function(err){
            console.log(err)
        })

    session
      .run('MATCH(p:Publisher) RETURN (p)')
      .then(function(result){
        var pubsArr = []
        result.records.forEach(function(record){
          pubsArr.push({
            id: record._fields[0].identity.low,
            name: record._fields[0].properties.name
          })
        })
        res.render('publishers', { title: 'Publishers', pubs: pubsArr });
      })
      .catch(function(err){
        console.log(err)
      })
})

router.post('/newpub', function(req, res){
  var name = req.body.name
    session
        .run(`CREATE(p:Publisher{name:'${name}'})`)
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