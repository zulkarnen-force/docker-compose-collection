// upload.js
const express = require("express");
const multer = require("multer");
const { S3Client, PutObjectCommand } = require("@aws-sdk/client-s3");
const fs = require("fs");
const path = require("path");

const app = express();
const upload = multer({ dest: "uploads/" });

const {
  CreateBucketCommand,
  HeadBucketCommand,
} = require("@aws-sdk/client-s3");

async function ensureBucketExists(bucketName) {
  try {
    await s3.send(new HeadBucketCommand({ Bucket: bucketName }));
    console.log("Bucket exists");
  } catch (err) {
    if (err.$metadata?.httpStatusCode === 404) {
      console.log("Creating bucket:", bucketName);
      await s3.send(new CreateBucketCommand({ Bucket: bucketName }));
    } else {
      throw err;
    }
  }
}

// S3 Client Config (for MinIO)
const s3 = new S3Client({
  region: "us-east-1", // MinIO doesn't enforce region, but required by SDK
  endpoint: "http://localhost:9002", // or http://minio.local if proxied via NGINX
  credentials: {
    accessKeyId: "minioadmin",
    secretAccessKey: "minioadminpassword",
  },
  forcePathStyle: true, // Required for MinIO!
});

// Upload route
app.post("/upload", upload.single("image"), async (req, res) => {
  const file = req.file;

  if (!file) return res.status(400).send("No file uploaded.");

  const fileStream = fs.createReadStream(file.path);

  const uploadParams = {
    Bucket: "my-bucket",
    Key: file.originalname,
    Body: fileStream,
    ContentType: file.mimetype,
  };

  console.log("Uploading file:", uploadParams);

  try {
    ensureBucketExists(uploadParams.Bucket);
    await s3.send(new PutObjectCommand(uploadParams));
    fs.unlinkSync(file.path); // cleanup local upload
    res.send("File uploaded to MinIO successfully.");
  } catch (err) {
    console.error(err);
    res.status(500).send("Error uploading file.");
  }
});

app.listen(3000, () => {
  console.log("Server running at http://localhost:3000");
});
