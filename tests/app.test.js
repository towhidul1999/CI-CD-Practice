import test from "node:test";
import assert from "node:assert/strict";
import request from "supertest";
import app from "../app.js";

test("GET / returns greeting", async () => {
  const res = await request(app).get("/");
  assert.equal(res.statusCode, 200);
  assert.match(res.text, /Hello from Express/i);
});

test("GET /health returns ok:true", async () => {
  const res = await request(app).get("/health");
  assert.equal(res.statusCode, 200);
  assert.equal(res.body.ok, true);
});