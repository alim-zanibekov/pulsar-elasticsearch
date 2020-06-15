curl --header "Content-Type: application/json" \
  --request DELETE \
  http://localhost:8080/admin/v2/tenants/tenant-1

curl --header "Content-Type: application/json" \
  --request PUT \
  --data '{ "allowedClusters": ["standalone"]}' \
  http://localhost:8080/admin/v2/tenants/tenant-1

curl --header "Content-Type: application/json" \
  --request PUT \
  --data '{}' \
  http://localhost:8080/admin/v2/namespaces/tenant-1/ns-1  

curl --header "Content-Type: multipart/form-data" \
  --request POST \
  -F url='file:///pulsar/connectors/pulsar-io-elastic-search-2.7.0-SNAPSHOT.nar;type=text/plain' \
  -F sinkConfig='{ "className": "org.apache.pulsar.io.elasticsearch.ElasticSearchSink", "archive": "/pulsar/connectors/pulsar-io-elastic-search-2.7.0-SNAPSHOT.nar", "inputs": ["persistent://tenant-1/ns-1/elastic-test"], "processingGuarantees": "EFFECTIVELY_ONCE", "parallelism": 1, "configs": {"elasticSearchUrl": "http://elasticsearch:9200", "indexName": "test_index" } };type=application/json' \
  http://localhost:8080/admin/v3/sinks/tenant-1/ns-1/elasticsearch


curl --request POST \
 http://localhost:8080/admin/v3/sinks/tenant-1/ns-1/elasticsearch/start

curl --request POST \
 http://localhost:8080/admin/v3/sinks/tenant-1/ns-1/elasticsearch/restart


# curl -s http://localhost:9200/test_index/_refresh
# curl -s http://localhost:9200/test_index/_search