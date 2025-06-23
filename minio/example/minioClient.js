const { S3Client } = require("@aws-sdk/client-s3");

const s3 = new S3Client({
  region: "us-east-1",
  endpoint: "https://staging.assets.rentalize.id", // or http://minio:9000 inside Docker
  credentials: {
    accessKeyId: "rentalizecdn",
    secretAccessKey: "rentalizeCDN@superSecret1945",
  },
  forcePathStyle: true,
});

module.exports = s3;
