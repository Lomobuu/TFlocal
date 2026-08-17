# Multi-stage: build the bundle with node, then ship only static files on nginx.
# The final image contains no node runtime and no node_modules.

# ---- build ----
# Vite 8 requires node ^20.19 || >=22.12; the 22-alpine tag satisfies that.
FROM node:22-alpine AS build
WORKDIR /app

# Copy manifests first so `npm ci` is cached until dependencies actually change.
COPY package.json package-lock.json ./
RUN npm ci

COPY . .
RUN npm run build

# ---- serve ----
FROM nginx:1.27-alpine
COPY nginx.conf /etc/nginx/conf.d/default.conf
COPY --from=build /app/dist /usr/share/nginx/html
EXPOSE 80
