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
  });

  await producer.flush();

  await producer.close();
  await client.close();
})();