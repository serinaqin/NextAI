import express from "express";
import cors from "cors";
import dotenv from "dotenv";
import multer from "multer";
import chat from "./chat.js";

dotenv.config();

const app = express();
app.use(cors());

// Configure multer
const storage = multer.diskStorage({
destination: function (req, file, cb) {
cb(null, "uploads/");
},
filename: function (req, file, cb) {
cb(null, file.originalname);
},
});
const upload = multer({ storage: storage });

const port = process.env.PORT || 8080;

let filePath;

app.post("/upload", upload.single("file"), async (req, res) => {
// Use multer to handle file upload
filePath = req.file.path; // temporarily saved
res.send(filePath + " upload successfully.");
});

app.get("/chat", async (req, res) => {
const resp = await chat(filePath, req.query.question); // Pass the file path to your main function
res.send(resp.text);
});

app.listen(port, () => {
console.log(`Server is running on port ${port}`);
});
