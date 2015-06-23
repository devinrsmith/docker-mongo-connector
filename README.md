# docker-mongo-connector

I'd like to get the test directory into a fresh, bootstrap-able state. It's not quite fully automatic right now. Here are the manual steps to get it running:

```
~/dev/docker-mongo-connector$ cd test

~/dev/docker-mongo-connector/test$ docker-compose up -d
Creating test_a1_1...
Creating test_a3_1...
Creating test_a2_1...
Creating test_mongo1_1...
Creating test_elasticsearch_1...
Creating test_mongo3_1...
Creating test_mongo2_1...
Creating test_mongoconnector_1...

~/dev/docker-mongo-connector$ docker exec -it test_elasticsearch_1 curl -XPUT http://localhost:9200/test
{"acknowledged":true}

~/dev/docker-mongo-connector/test$ docker exec -it test_mongo1_1 mongo
MongoDB shell version: 3.0.4
connecting to: test
Welcome to the MongoDB shell.
For interactive help, type "help".
For more comprehensive documentation, see
	http://docs.mongodb.org/
Questions? Try the support group
	http://groups.google.com/group/mongodb-user
> rs.initiate()
{
	"info2" : "no configuration explicitly specified -- making one",
	"me" : "mongo1:27017",
	"ok" : 1
}
rs0:SECONDARY> rs.add("mongo2")
{ "ok" : 1 }
rs0:PRIMARY> rs.add("mongo3")
{ "ok" : 1 }
rs0:PRIMARY> db.inventory.insert(
...    {
...      item: "ABC1",
...      details: {
...         model: "14Q3",
...         manufacturer: "XYZ Company"
...      },
...      stock: [ { size: "S", qty: 25 }, { size: "M", qty: 50 } ],
...      category: "clothing"
...    }
... )
rs0:PRIMARY> exit
bye

~/dev/docker-mongo-connector/test$ docker-compose start
Starting test_mongoconnector_1...

~/dev/docker-mongo-connector/test$ docker exec -it test_elasticsearch_1 curl http://localhost:9200/test
{"test":{"aliases":{},"mappings":{"inventory":{"properties":{"category":{"type":"string"},"details":{"properties":{"manufacturer":{"type":"string"},"model":{"type":"string"}}},"item":{"type":"string"},"stock":{"properties":{"qty":{"type":"double"},"size":{"type":"string"}}}}}},"settings":{"index":{"creation_date":"1435085716774","number_of_shards":"5","number_of_replicas":"1","version":{"created":"1060099"},"uuid":"LH2QhoAmTEK1JlBiB--Utg"}},"warmers":{}}}
```
