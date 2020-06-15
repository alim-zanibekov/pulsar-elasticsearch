const Pulsar = require('pulsar-client');

(async () => {
  const client = new Pulsar.Client({
    serviceUrl: 'pulsar://localhost:6650',
  });

  const producer = await client.createProducer({
    topic: 'persistent://tenant-1/ns-1/elastic-test',
  });

  const msg = `{ "test-pulsar": ${Math.random()} }`;

  producer.send({
    data: Buffer.from(msg),
    properties: { 'ACTION': 'UPSERT', 'ID': 'Ynkmo3IByAKwM8v_vbqU' }
  });

  /*

  // Update or Insert, ID not required
  // Can insert with specific ID

  producer.send({
    data: Buffer.from(msg),
    properties: { 'ACTION': 'UPSERT' }
  });

  // Delete, ID required

  producer.send({
    data: Buffer.from(""),
    properties: { 'ACTION': 'DELETE', 'ID': 'Ynkmo3IByAKwM8v_vbqU' }
  });

  */


  await producer.flush();

  await producer.close();
  await client.close();
})();