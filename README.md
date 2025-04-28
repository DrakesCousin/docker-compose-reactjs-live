# docker-compose-reactjs-live

A Docker + Bun + Nginx setup for live-deploying a React.js frontend directly from a private GitHub repo. On container restart, the entrypoint pulls the latest code, installs dependencies, builds with Bun, and serves via Nginx with persistent logs.

## Prerequisites

- Docker & Docker Compose installed
- A GitHub Personal Access Token (PAT) with **repo** scope
- Network access to `github.com`

## Setup

1. **Clone this repo**
   ```bash
   git clone https://github.com/BaseMax/docker-compose-reactjs-live.git
   cd docker-compose-reactjs-live
   ```

2. Create log directory

   ```bash
   mkdir -p nginx/logs
   ```

3. Configure environment

Copy `.env.example` to `.env`:

   ```bash
   cp .env.example .env
   ```

Edit `.env` and set:

```
github_token=ghp_<YOUR_TOKEN>
repo_url=https://github.com/your-username/your-private-repo.git
branch=main
```

## Usage

- Create an empty folder `nginx/logs`.
- Copy `.env.example` to `.env` and set your `github_token` and `repo_url` (and `branch` if desired).

**Launch:**

```bash
docker compose up -d --build
```

**To deploy updates:**

```bash
docker compose restart frontend
```

This pulls, rebuilds, and reloads automatically.

**More commands:**

```
docker compose up -d --build
docker ps
docker logs docker-compose-reactjs-live-frontend-1
docker run --env-file .env -it docker-compose-reactjs-live-frontend /bin/sh
```

```
docker-compose down
docker-compose up -d
```
## Notes

- **Env file:** Now contains both repo_url and github_token (plus optional branch), keeping credentials and URLs out of Compose.
- **Git auth:** entrypoint.sh uses Netrc to authenticate.
- **Persistence:** Named volume app-data retains the cloned repo.
- **Logs:** Nginx logs map to ./nginx/logs for easy access.
- **Updates:** Simple container restart handles pulling, building, and serving.

Copyright 2025, Max Base
