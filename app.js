import express from "express";
const app = express();

app.get("/", (req, res) => res.send("Helloo from Express Docker"));

app.get("/health", (req, res) => res.json({ ok: true, service: "express-gha-demo" }));

export default app;