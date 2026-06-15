# 🐳 Docker Task - 2 | Personal Details Web App

<div align="center">

![Docker](https://img.shields.io/badge/Docker-2496ED?style=for-the-badge&logo=docker&logoColor=white)
![Nginx](https://img.shields.io/badge/Nginx-009639?style=for-the-badge&logo=nginx&logoColor=white)
![AWS](https://img.shields.io/badge/AWS_EC2-FF9900?style=for-the-badge&logo=amazonaws&logoColor=white)
![Docker Compose](https://img.shields.io/badge/Docker_Compose-2496ED?style=for-the-badge&logo=docker&logoColor=white)
![Status](https://img.shields.io/badge/Status-Deployed-success?style=for-the-badge)

### ✨ A Dockerized, animated, glassmorphism-style profile card — deployed live on AWS EC2 ✨

</div>

---

## 📋 Overview

This project containerizes a colorful, interactive personal-details webpage using **Docker** + **Nginx**, orchestrated with **Docker Compose**, and deployed on an **AWS EC2** instance.

> 🎯 Goal: Spin up a single container that serves a slick personal info page on port `8080`.

---

## 🛠️ Tech Stack

| Layer | Technology |
|-------|-----------|
| ☁️ Cloud | AWS EC2 (Ubuntu) |
| 📦 Containerization | Docker |
| 🧩 Orchestration | Docker Compose |
| 🌐 Web Server | Nginx |
| 🎨 Frontend | HTML5 + CSS3 (animated gradients, glassmorphism) |

---

## 📁 Project Structure

```
Docker Task 2/
├── 🐳 Dockerfile
├── 🧩 docker-compose.yml
├── 🌐 index.html
├── 📄 README.md
└── 📸 Screenshots/
    ├── 01-website-output.png
    ├── 02-ec2-running.png
    ├── 03-ssh-connect.png
    ├── 04-docker-installed.png
    ├── 05-github-repo.png
    └── 06-docker-compose-up.png
```

---

## 🚀 Quick Start

### 1️⃣ Clone the repo
```bash
git clone https://github.com/mussadiq-ops/DevOps-Assignments.git
cd "DevOps-Assignments/Docker Task 2"
```

### 2️⃣ Build & run with Docker Compose
```bash
docker compose up -d --build
```

### 3️⃣ Verify the container is running
```bash
docker ps
```

### 4️⃣ Open in browser 🎉
```
http://<EC2-Public-IP>:8080
```

---

## 🐳 Dockerfile

```dockerfile
FROM nginx:latest
COPY index.html /usr/share/nginx/html/index.html
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]
```

## 🧩 docker-compose.yml

```yaml
services:
  webapp:
    build: .
    container_name: my_details_app
    ports:
      - "8080:80"
    restart: always
```

---

## 🖼️ Live Preview

<div align="center">

> 🌈 An animated gradient background with a glowing glassmorphism card displaying:
> - 🎓 Course details
> - 📦 Task info
> - 📧 Contact email
> - 🌍 Deployment platform
> - 🏷️ Tech stack tags

</div>

📸 *See `/Screenshots` folder for the full deployment walkthrough — EC2 setup, Docker install, build logs, and live output.*

---

## ☁️ AWS EC2 Deployment Steps

1. 🖥️ Launch Ubuntu EC2 instance (`t3.micro`)
2. 🔓 Open inbound port `8080` in Security Group
3. 🔑 SSH into the instance
4. 📥 Install Docker & Docker Compose
5. 📂 Clone this repo
6. ▶️ Run `docker compose up -d --build`
7. 🌐 Access via `http://<Public-IP>:8080`

---

## 👤 Author

**Mussadiq Ali Abbas**  
📧 mussadiq.116@gmail.com  
🚀 DevOps Enthusiast

---

<div align="center">

### 🐳 Containerized with Docker | ☁️ Deployed on AWS EC2 | 💖 Made with passion

![Made with Love](https://img.shields.io/badge/Made%20with-%E2%9D%A4-red?style=flat-square)

</div>
