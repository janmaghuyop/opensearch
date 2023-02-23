Opensearch
==========

##### Links
- https://opensearch.org/docs/latest/quickstart/
- https://opendistro.github.io/for-elasticsearch-docs/docs/security/configuration/yaml


##### Usage
```bash
vagrant up
vagrant ssh

docker-compose pull

docker-compose up -d opensearch
docker-compose up -d logstash
docker-compose up -d dashboard

docker-compose ps
docker-compose logs -f opensearch
docker-compose logs -f logstash
docker-compose logs -f dashboard

# test in host
telnet 192.168.56.110 9200

# check status
curl -k -u admin:admin -XGET https://192.168.56.110:9200/_cluster/health?pretty

# show indices
curl -sS -k -u admin:admin -XGET \
"https://192.168.56.110:9200/_cat/shards?h=index,shards,state,prirep,unassigned.reason"

# delete unassigned shards
curl -sS -k -u admin:admin -XGET \
"https://192.168.56.110:9200/_cat/shards" | grep UNASSIGNED | awk {'print $1'} | xargs -i \
curl -sS -k -u admin:admin -XDELETE "https://192.168.56.110:9200/{}"


# set index template
curl -sS -L -X PUT -k -u admin:admin \
'https://192.168.56.110:9200/_index_template/all-index-template-01' \
-H "Content-Type: application/json" \
-d @index_template.json

# create index patterns
curl -k -X POST -k -u admin:admin \
http://192.168.56.110:5601/api/saved_objects/index-pattern/logstash* \
-H "securitytenant:global" \
-H "osd-xsrf:true" \
-H "content-type:application/json" \
-d @index_patterns.json


# HASH PASSWORD
docker-compose exec opensearch bash
plugins/opensearch-security/tools/hash.sh -p PASSWORD
```

##### Curator
```bash
docker-compose build curator
docker-compose up -d curator
docker-compose logs -f curator
```
