# ---- Build stage (if you had TS or build steps; fine for JS too) ----
FROM node:22-alpine AS build
WORKDIR /app
COPY package*.json ./
RUN npm ci
COPY . .
# If you had TypeScript or build steps, do them here:
# RUN npm run build

# ---- Runtime stage ----
FROM node:22-alpine
ENV NODE_ENV=production
WORKDIR /app

# Copy only what's needed to run
COPY --from=build /app/package*.json ./
RUN npm ci --omit=dev

COPY --from=build /app/. ./

# Security: run as non-root
RUN addgroup -S nodegrp && adduser -S nodeusr -G nodegrp
USER nodeusr

EXPOSE 3000
ENV PORT=3000

# Optional healthcheck (works in compose/k8s, not on Docker Hub itself)
HEALTHCHECK --interval=30s --timeout=3s CMD wget -qO- http://localhost:${PORT}/health || exit 1

CMD ["npm","start"]