<div align="center">

```
██████╗  ██████╗  ██████╗██╗  ██╗███████╗██████╗     ████████╗ █████╗ ███████╗██╗  ██╗    ██████╗ 
██╔══██╗██╔═══██╗██╔════╝██║ ██╔╝██╔════╝██╔══██╗    ╚══██╔══╝██╔══██╗██╔════╝██║ ██╔╝    ╚════██╗
██║  ██║██║   ██║██║     █████╔╝ █████╗  ██████╔╝       ██║   ███████║███████╗█████╔╝      █████╔╝
██║  ██║██║   ██║██║     ██╔═██╗ ██╔══╝  ██╔══██╗       ██║   ██╔══██║╚════██║██╔═██╗      ╚═══██╗
██████╔╝╚██████╔╝╚██████╗██║  ██╗███████╗██║  ██║       ██║   ██║  ██║███████║██║  ██╗    ██████╔╝
╚═════╝  ╚═════╝  ╚═════╝╚═╝  ╚═╝╚══════╝╚═╝  ╚═╝       ╚═╝   ╚═╝  ╚═╝╚══════╝╚═╝  ╚═╝    ╚═════╝ 
```

# 🐳 Custom Nginx Docker Image — Task 3

### *Build · Push · Deploy · Automate*

[![Docker](https://img.shields.io/badge/Docker-29.5.3-2496ED?style=for-the-badge&logo=docker&logoColor=white)](https://www.docker.com/)
[![Nginx](https://img.shields.io/badge/Nginx-Latest-009639?style=for-the-badge&logo=nginx&logoColor=white)](https://nginx.org/)
[![AWS EC2](https://img.shields.io/badge/AWS_EC2-t3.micro-FF9900?style=for-the-badge&logo=amazon-aws&logoColor=white)](https://aws.amazon.com/ec2/)
[![Docker Compose](https://img.shields.io/badge/Docker_Compose-2.40.3-2496ED?style=for-the-badge&logo=docker&logoColor=white)](https://docs.docker.com/compose/)
[![Docker Hub](https://img.shields.io/badge/Docker_Hub-mussadiq116-2496ED?style=for-the-badge&logo=docker&logoColor=white)](https://hub.docker.com/r/mussadiq116/custom-nginx)

</div>

---

## 📋 Task Overview

> **Goal:** Create a **custom Docker image** for Nginx, deploy it using **Docker Compose** with a **volume bind mount at `/var/opt/nginx`**, and push the image to **Docker Hub** — all hosted on **AWS EC2**.

```
┌─────────────────────────────────────────────────────────────────┐
│                     TASK ARCHITECTURE                           │
│                                                                 │
│   ┌──────────┐    docker build    ┌──────────────────────┐     │
│   │Dockerfile│ ─────────────────► │ custom-nginx:latest  │     │
│   └──────────┘                    └──────────┬───────────┘     │
│                                              │                  │
│                                    docker push│                 │
│                                              ▼                  │
│                                   ┌──────────────────┐         │
│                                   │   Docker Hub     │         │
│                                   │ mussadiq116/     │         │
│                                   │  custom-nginx    │         │
│                                   └──────────┬───────┘         │
│                                              │                  │
│                                   docker compose up            │
│                                              ▼                  │
│   ┌──────────────────────────────────────────────────────┐     │
│   │                   AWS EC2 (t3.micro)                 │     │
│   │  ┌────────────────────────────────────────────────┐  │     │
│   │  │          custom-nginx-container                │  │     │
│   │  │    Port 80:80  │  Port 443:443                 │  │     │
│   │  │                │                               │  │     │
│   │  │  Bind Mount: /var/opt/nginx ◄──► /var/opt/nginx│  │     │
│   │  └────────────────────────────────────────────────┘  │     │
│   └──────────────────────────────────────────────────────┘     │
└─────────────────────────────────────────────────────────────────┘
```

---

## 🏗️ Project Structure

```
📁 Docker Task 3/
│
├── 🐳 Dockerfile               ← Custom Nginx image definition
├── 📄 docker-compose.yml       ← Compose config with bind mount
├── ⚙️  nginx.conf               ← Main Nginx configuration
├── ⚙️  default.conf             ← Server block (logs → /var/opt/nginx)
├── 🌐 index.html               ← Custom landing page
├── 🔧 setup.sh                 ← Automated deployment script
└── 📁 Screenshots/             ← Output screenshots
```

---

## 🛠️ Tech Stack

| Technology | Version | Purpose |
|:---:|:---:|:---|
| ![AWS](https://img.shields.io/badge/-AWS_EC2-FF9900?style=flat-square&logo=amazon-aws&logoColor=white) | t3.micro | Cloud hosting infrastructure |
| ![Docker](https://img.shields.io/badge/-Docker-2496ED?style=flat-square&logo=docker&logoColor=white) | 29.5.3 | Container engine |
| ![Compose](https://img.shields.io/badge/-Docker_Compose-2496ED?style=flat-square&logo=docker&logoColor=white) | 2.40.3 | Multi-container orchestration |
| ![Nginx](https://img.shields.io/badge/-Nginx-009639?style=flat-square&logo=nginx&logoColor=white) | Latest | Web server (custom image base) |
| ![Docker Hub](https://img.shields.io/badge/-Docker_Hub-2496ED?style=flat-square&logo=docker&logoColor=white) | — | Container image registry |

---

## 🚀 Step-by-Step Execution

### Step 1 — Launch AWS EC2 Instance

```bash
# Instance: t3.micro | OS: Ubuntu 22.04 LTS
# Region: ap-south-2 (Hyderabad)
# Security Group Inbound Rules:
#   ✅ Port 22   → SSH
#   ✅ Port 80   → HTTP (Nginx)
#   ✅ Port 8080 → Custom TCP

ssh -i devops-task.pem ubuntu@18.60.105.91
```

---

### Step 2 — Clone Repository on EC2

```bash
git clone https://github.com/mussadiq-ops/DevOps-Assignments.git
cd DevOps-Assignments/Docker\ Task\ 3
ls
# Dockerfile  default.conf  docker-compose.yml  index.html  nginx.conf  setup.sh
```

---

### Step 3 — Install Docker & Docker Compose

```bash
chmod +x setup.sh
./setup.sh

# Verify installation
docker --version
# Docker version 29.5.3, build d1c06ef

docker compose version
# Docker Compose version 2.40.3+ds1-0ubuntu1

sudo systemctl start docker
sudo systemctl enable docker
sudo systemctl status docker
# ● docker.service - Docker Application Container Engine
#    Active: active (running)
```

---

### Step 4 — Create Volume Bind Mount Directory

```bash
# ⭐ TASK REQUIREMENT: Volume bind mount at /var/opt/nginx
sudo mkdir -p /var/opt/nginx
ls /var/opt
# nginx ✅
```

---

### Step 5 — Build Custom Docker Image

```bash
sudo docker build -t custom-nginx:latest .
```

```
[+] Building 12.3s (13/13) FINISHED                    docker:default
 => [internal] load build definition from Dockerfile          0.0s
 => [internal] load metadata for docker.io/library/nginx      0.7s
 => [internal] load .dockerignore                             0.0s
 => [1/8] FROM docker.io/library/nginx:latest                 0.0s
 => [2/8] RUN apt-get update && apt-get install -y curl vim   6.8s
 => [3/8] RUN rm /etc/nginx/conf.d/default.conf               0.3s
 => [4/8] COPY nginx-config/nginx.conf /etc/nginx/nginx.conf  0.1s
 => [5/8] COPY nginx-config/default.conf /etc/nginx/conf.d/   0.0s
 => [6/8] COPY html/ /usr/share/nginx/html/                   0.0s
 => [7/8] RUN mkdir -p /var/opt/nginx && chown -R nginx:nginx  0.2s
 => [8/8] RUN mkdir -p /var/log/nginx                         0.3s
 => exporting to image                                        3.5s
 => naming to docker.io/library/custom-nginx:latest           0.8s
```

```bash
docker images
# IMAGE                   ID            DISK USAGE   CONTENT SIZE
# custom-nginx:latest     f65a07f593b4  304MB        78MB        ✅
```

---

### Step 6 — Push to Docker Hub

```bash
docker login -u mussadiq116
# Login Succeeded ✅

docker tag custom-nginx:latest mussadiq116/custom-nginx:latest
docker push mussadiq116/custom-nginx:latest

# The push refers to repository [docker.io/mussadiq116/custom-nginx]
# All layers: Pushed ✅
# latest: digest: sha256:f65a07f593b4...  size: 856
```

🔗 **Docker Hub:** [hub.docker.com/r/mussadiq116/custom-nginx](https://hub.docker.com/r/mussadiq116/custom-nginx)

---

### Step 7 — Deploy with Docker Compose

```bash
# Update image name in docker-compose.yml
nano docker-compose.yml
# image: mussadiq116/custom-nginx:latest

sudo docker compose up -d
```

```
[+] Running 2/2
 ✔ Network  dockertask3_nginx-network    Created    0.1s
 ✔ Container custom-nginx-container      Started    0.3s
```

```bash
docker ps
```

```
CONTAINER ID   IMAGE                 COMMAND                  CREATED         STATUS              PORTS
a182b55c522c   custom-nginx:latest   "/docker-entrypoint…"   9 seconds ago   Up 8 seconds (healthy)
               0.0.0.0:80->80/tcp, [::]:80->80/tcp, 0.0.0.0:443->443/tcp
               custom-nginx-container
```

---

### Step 8 — Verify Volume Bind Mount

```bash
# ⭐ Confirm bind mount is active
docker inspect custom-nginx-container | grep -A 5 "Mounts"

# "Type": "bind",
# "Source": "/var/opt/nginx",    ← Host path
# "Destination": "/var/opt/nginx" ← Container path ✅

ls /var/opt/nginx/
# access.log  error.log   (auto-generated by Nginx) ✅
```

---

## 📁 Key Files Explained

### `Dockerfile`

```dockerfile
FROM nginx:latest

LABEL maintainer="mussadiq116"
LABEL description="Custom Nginx image for Docker Task 3"

RUN apt-get update && apt-get install -y curl vim && apt-get clean

RUN rm /etc/nginx/conf.d/default.conf
COPY nginx-config/nginx.conf /etc/nginx/nginx.conf
COPY nginx-config/default.conf /etc/nginx/conf.d/default.conf
COPY html/ /usr/share/nginx/html/

# ⭐ Create bind mount directory
RUN mkdir -p /var/opt/nginx && \
    chown -R nginx:nginx /var/opt/nginx && \
    chmod -R 755 /var/opt/nginx

EXPOSE 80
EXPOSE 443

HEALTHCHECK --interval=30s --timeout=10s --retries=3 \
    CMD curl -f http://localhost/ || exit 1

CMD ["nginx", "-g", "daemon off;"]
```

---

### `docker-compose.yml`

```yaml
version: '3.8'

services:
  custom-nginx:
    image: mussadiq116/custom-nginx:latest
    container_name: custom-nginx-container

    ports:
      - "80:80"
      - "443:443"

    # ⭐ TASK REQUIREMENT: Volume bind mount at /var/opt/nginx
    volumes:
      - type: bind
        source: /var/opt/nginx    # Host EC2 path
        target: /var/opt/nginx    # Container path

    restart: unless-stopped

    healthcheck:
      test: ["CMD", "curl", "-f", "http://localhost/health"]
      interval: 30s
      timeout: 10s
      retries: 3
      start_period: 10s

    networks:
      - nginx-network

networks:
  nginx-network:
    driver: bridge
```

---

## ✅ Task Completion Checklist

| Requirement | Status | Evidence |
|:---|:---:|:---|
| Custom Docker image for Nginx | ✅ | `custom-nginx:latest` built successfully |
| Deployed using Docker Compose | ✅ | `docker compose up -d` — container Started |
| Volume bind mount at `/var/opt/nginx` | ✅ | `source: /var/opt/nginx` in compose file |
| Image pushed to Docker Hub | ✅ | `mussadiq116/custom-nginx` — all layers pushed |
| Running on AWS EC2 | ✅ | EC2 `Docker-task-3` — Running, 3/3 checks passed |
| Website accessible via browser | ✅ | `http://18.60.105.91` serving custom page |
| Files pushed to GitHub | ✅ | `mussadiq-ops/DevOps-Assignments/Docker Task 3` |

---

## 🔧 Useful Commands

```bash
# ── Container Management ──────────────────────────────────
docker compose up -d              # Start in background
docker compose down               # Stop & remove containers
docker compose logs -f            # Follow logs
docker compose restart            # Restart services

# ── Inspection ────────────────────────────────────────────
docker ps                         # List running containers
docker inspect custom-nginx-container    # Full container details
docker exec -it custom-nginx-container bash   # Enter container

# ── Volume Verification ───────────────────────────────────
ls -la /var/opt/nginx/            # View bind mount contents
docker inspect custom-nginx-container | grep -A 8 "Mounts"

# ── Nginx ─────────────────────────────────────────────────
docker exec custom-nginx-container nginx -t        # Test config
curl http://localhost/            # Test locally
curl http://localhost/health      # Health endpoint

# ── Image Management ──────────────────────────────────────
docker images                     # List all images
docker rmi custom-nginx:latest    # Remove image
docker pull mussadiq116/custom-nginx:latest   # Pull from Hub
```

---

## 📸 Screenshots

| # | Screenshot | Description |
|:---:|:---|:---|
| 01 | `01-project-files.png` | Local project files in Windows Explorer |
| 02 | `02-github-push.png` | Files pushed to GitHub repository |
| 03 | `03-ec2-instance.png` | AWS EC2 instance Running |
| 04 | `04-docker-install.png` | Docker & Compose installed on EC2 |
| 05 | `05-docker-build-success.png` | `docker build` — 13/13 FINISHED |
| 06 | `06-dockerhub-repo.png` | Docker Hub — `mussadiq116/custom-nginx` |
| 07 | `07-docker-images.png` | `docker images` output (304MB) |
| 08 | `08-compose-up-running.png` | `docker compose up` + container healthy |
| 09 | `09-nginx-browser.png` | Website live at `18.60.105.91` |
| 10 | `10-docker-push.png` | All layers pushed to Docker Hub |

---

## 🔗 Links

| Resource | URL |
|:---|:---|
| 🐙 GitHub Repo | [github.com/mussadiq-ops/DevOps-Assignments](https://github.com/mussadiq-ops/DevOps-Assignments/tree/main/Docker%20Task%203) |
| 🐳 Docker Hub | [hub.docker.com/r/mussadiq116/custom-nginx](https://hub.docker.com/r/mussadiq116/custom-nginx) |
| 🌐 Live Site | [http://18.60.105.91](http://18.60.105.91) |

---

<div align="center">

**Built with ❤️ by Mussadiq A.**

*CloudOps Engineer · Cognizant · Chennai, India*

[![LinkedIn](https://img.shields.io/badge/LinkedIn-Connect-0A66C2?style=for-the-badge&logo=linkedin&logoColor=white)](https://linkedin.com)
[![GitHub](https://img.shields.io/badge/GitHub-Follow-181717?style=for-the-badge&logo=github&logoColor=white)](https://github.com/mussadiq-ops)

```
"Automate the boring stuff."
```

</div>
