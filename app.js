import express from "express";
const app = express();

app.get("/", (req, res) => res.send("Hello from Express Dockerrrrrrrr"));

app.get("/health", (req, res) => res.json({ ok: true, service: "express-gha-demo" }));

export default app;