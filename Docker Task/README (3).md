# 🐳 Docker Task — EC2 Setup & Docker Exploration

<div align="center">

![Docker](https://img.shields.io/badge/Docker-25.0.14-2496ED?style=for-the-badge&logo=docker&logoColor=white)
![AWS EC2](https://img.shields.io/badge/AWS-EC2-FF9900?style=for-the-badge&logo=amazonec2&logoColor=white)
![Amazon Linux](https://img.shields.io/badge/Amazon_Linux-2023-232F3E?style=for-the-badge&logo=amazonaws&logoColor=white)
![Nginx](https://img.shields.io/badge/Nginx-1.31.1-009639?style=for-the-badge&logo=nginx&logoColor=white)
![Status](https://img.shields.io/badge/Status-Completed-0F6E56?style=for-the-badge)

**Hands-on exploration of Docker on AWS EC2 — Images, Containers, Volumes & Networks**

</div>

---

## 📋 Table of Contents

- [Overview](#-overview)
- [Tech Stack](#-tech-stack)
- [Environment Setup](#-environment-setup)
- [Docker Commands Explored](#-docker-commands-explored)
  - [Images](#-images)
  - [Containers](#-containers)
  - [Volumes](#-volumes)
  - [Networks](#-networks)
- [Screenshots](#-screenshots)
- [Project Structure](#-project-structure)

---

## 🎯 Overview

This task covers installing Docker on an AWS EC2 instance and exploring the four core Docker concepts:

| Concept | What it is | Commands Used |
|---|---|---|
| **Images** | Blueprints for containers | `pull`, `images`, `inspect` |
| **Containers** | Running instances of images | `run`, `ps`, `logs`, `exec` |
| **Volumes** | Persistent storage | `volume create`, `ls`, `inspect` |
| **Networks** | Container communication | `network create`, `ls`, `inspect` |

---

## 🛠 Tech Stack

- **Cloud:** AWS EC2 (t2.micro, ap-south-1 / Mumbai)
- **OS:** Amazon Linux 2023
- **Runtime:** Docker 25.0.14
- **Image Used:** nginx:latest

---

## ⚙️ Environment Setup

### 1. Launch EC2 Instance

- **Instance Type:** t2.micro (Free Tier)
- **AMI:** Amazon Linux 2023
- **Region:** ap-south-1 (Mumbai)
- **Security Group:** Port 22 (SSH) + Port 80 (HTTP)

### 2. Install Docker

```bash
# Update packages
sudo yum update -y

# Install Docker
sudo yum install docker -y

# Start and enable Docker service
sudo systemctl start docker
sudo systemctl enable docker

# Add user to docker group (no sudo needed)
sudo usermod -aG docker ec2-user

# Logout and log back in, then verify
docker --version
# Docker version 25.0.14, build 0bab007
```

---

## 🔍 Docker Commands Explored

### 🖼 Images

```bash
# Pull nginx image from Docker Hub
docker pull nginx

# List all local images
docker images

# Inspect image metadata (layers, config, env vars)
docker inspect nginx
```

<details>
<summary>📌 What these commands do</summary>

- `docker pull` — Downloads the image from Docker Hub registry
- `docker images` — Shows all images stored locally with size and tag
- `docker inspect` — Returns full JSON metadata including layers, entrypoint, exposed ports, environment variables

</details>

---

### 📦 Containers

```bash
# Run nginx container in detached mode on port 80
docker run -d --name my-nginx -p 80:80 nginx

# List running containers
docker ps

# View container logs
docker logs my-nginx

# Execute bash shell inside running container
docker exec -it my-nginx bash
```

<details>
<summary>📌 Flag breakdown</summary>

| Flag | Meaning |
|---|---|
| `-d` | Detached mode — runs in background |
| `--name my-nginx` | Assigns a name to the container |
| `-p 80:80` | Maps host port 80 → container port 80 |
| `-it` | Interactive terminal (for exec) |

</details>

---

### 💾 Volumes

```bash
# Create a named volume
docker volume create my-vol

# List all volumes
docker volume ls

# Inspect volume details (mountpoint, driver)
docker volume inspect my-vol

# Run container with volume attached
docker run -d --name vol-test -v my-vol:/data nginx
```

<details>
<summary>📌 Why volumes matter</summary>

By default, container data is lost when the container is removed. Volumes persist data on the host machine independently of the container lifecycle. The `-v my-vol:/data` flag mounts `my-vol` at `/data` inside the container.

</details>

---

### 🌐 Networks

```bash
# Create a custom bridge network
docker network create my-net

# List all networks
docker network ls

# Inspect network (subnet, gateway, connected containers)
docker network inspect my-net

# Run container attached to custom network
docker run -d --name net-test --network my-net nginx
```

<details>
<summary>📌 Default networks in Docker</summary>

| Network | Driver | Purpose |
|---|---|---|
| `bridge` | bridge | Default network for containers |
| `host` | host | Shares host network stack |
| `none` | null | No networking |
| `my-net` | bridge | Custom isolated network |

</details>

---

## 📸 Screenshots

<details>
<summary>🔧 Docker Installation</summary>

![Docker Install](devops/01-docker-install.png)
![Install Complete](devops/02-docker-install-complete.png)
![Enable & Usermod](devops/03-docker-enable-usermod.png)

</details>

<details>
<summary>🖼 Images</summary>

![Docker Pull](devops/04-docker-pull-nginx.png)
![Docker Images](devops/05-docker-images.png)
![Inspect Part 1](devops/06-docker-inspect-1.png)
![Inspect Part 2](devops/07-docker-inspect-2.png)

</details>

<details>
<summary>📦 Containers</summary>

![Docker Run](devops/08-docker-run-container.png)
![Docker PS](devops/09-docker-ps.png)
![Docker Logs](devops/10-docker-logs.png)
![Docker Exec](devops/11-docker-exec-bash.png)

</details>

<details>
<summary>💾 Volumes</summary>

![Volume Create](devops/12-docker-volume-create.png)
![Volume Inspect](devops/13-docker-volume-inspect.png)
![Volume Run](devops/14-docker-volume-run.png)

</details>

<details>
<summary>🌐 Networks</summary>

![Network Create](devops/15-docker-network-create.png)
![Network Inspect](devops/16-docker-network-inspect.png)
![Network Run](devops/17-docker-network-run.png)

</details>

<details>
<summary>✅ Final State</summary>

![All Containers Running](devops/18-docker-ps-all.png)
![Nginx Browser](devops/19-nginx-browser.png)

</details>

---

## 📁 Project Structure

```
Docker Task/
├── Dockerfile
├── index.html
├── README.md
└── devops/
    ├── 01-docker-install.png
    ├── 02-docker-install-complete.png
    ├── 03-docker-enable-usermod.png
    ├── 04-docker-pull-nginx.png
    ├── 05-docker-images.png
    ├── 06-docker-inspect-1.png
    ├── 07-docker-inspect-2.png
    ├── 08-docker-run-container.png
    ├── 09-docker-ps.png
    ├── 10-docker-logs.png
    ├── 11-docker-exec-bash.png
    ├── 12-docker-volume-create.png
    ├── 13-docker-volume-inspect.png
    ├── 14-docker-volume-run.png
    ├── 15-docker-network-create.png
    ├── 16-docker-network-inspect.png
    ├── 17-docker-network-run.png
    ├── 18-docker-ps-all.png
    └── 19-nginx-browser.png
```

---

<div align="center">

Made with 💙 | AWS EC2 + Docker | ap-south-1

</div>
