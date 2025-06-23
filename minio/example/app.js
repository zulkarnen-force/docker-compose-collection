const express = require("express");
const multer = require("multer");
const fs = require("fs");
const path = require("path");
const { PutObjectCommand } = require("@aws-sdk/client-s3");
const s3 = require("./minioClient");

const app = express();
const upload = multer({ dest: "uploads/" });

const BUCKET = "my-bucket";
const DB_PATH = path.join(__dirname, "data", "db.json");

// Ensure db file exists
if (!fs.existsSync(DB_PATH)) fs.writeFileSync(DB_PATH, "[]", "utf-8");

const readDB = () => JSON.parse(fs.readFileSync(DB_PATH));
const writeDB = (data) =>
  fs.writeFileSync(DB_PATH, JSON.stringify(data, null, 2));

app.use(express.json());
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
// Upload route
app.post("/upload", upload.single("image"), async (req, res) => {
  const file = req.file;
  if (!file) return res.status(400).send("No file uploaded.");

  const fileStream = fs.createReadStream(file.path);
  const objectKey = `${Date.now()}-${file.originalname}`;

  const uploadParams = {
    Bucket: BUCKET,
    Key: objectKey,
    Body: fileStream,
    ContentType: file.mimetype,
  };

  try {
    await ensureBucketExists(BUCKET);
    await s3.send(new PutObjectCommand(uploadParams));
    fs.unlinkSync(file.path);

    const publicUrl = `https://staging.assets.rentalize.id/my-bucket/${objectKey}`; // for production: use NGINX reverse proxy

    const db = readDB();
    db.push({
      filename: file.originalname,
      key: objectKey,
      url: publicUrl,
      uploaded_at: new Date().toISOString(),
    });
    writeDB(db);

    res.json({ success: true, url: publicUrl });
  } catch (err) {
    console.error(err);
    res.status(500).send("Upload failed.");
  }
});

// Serve database
app.get("/images", (req, res) => {
  res.json(readDB());
});

app.listen(3000, () => {
  console.log("Server started on http://localhost:3000");
});
