# ☁️ AWS Task 3 — S3 + CloudWatch & EC2 + Load Balancer

<div align="center">

![AWS](https://img.shields.io/badge/Amazon_AWS-FF9900?style=for-the-badge&logo=amazonaws&logoColor=white)
![Amazon S3](https://img.shields.io/badge/Amazon_S3-569A31?style=for-the-badge&logo=amazons3&logoColor=white)
![Amazon EC2](https://img.shields.io/badge/Amazon_EC2-FF9900?style=for-the-badge&logo=amazonec2&logoColor=white)
![CloudWatch](https://img.shields.io/badge/CloudWatch-FF4F8B?style=for-the-badge&logo=amazonaws&logoColor=white)

> **Secure cloud storage with audit logging + scalable web servers behind a load balancer**

</div>

---

## 📋 Table of Contents

- [Overview](#-overview)
- [Architecture](#-architecture)
- [Tech Stack](#-tech-stack)
- [Part 1 — S3 + CloudWatch](#-part-1--s3-bucket--cloudwatch-logging)
- [Part 2 — EC2 + Load Balancer](#-part-2--ec2-instances--application-load-balancer)
- [Screenshots](#-screenshots)
- [Key Learnings](#-key-learnings)
- [Folder Structure](#-folder-structure)

---

## 🌐 Overview

This task demonstrates two fundamental AWS production patterns used by every major tech company:

| # | What | Why |
|---|------|-----|
| 1 | **Private S3 bucket + CloudWatch audit logs** | Secure file storage with real-time activity monitoring |
| 2 | **Two EC2 instances behind an Application Load Balancer** | High-availability web serving with hidden backend IPs |

---

## 🏗️ Architecture

```
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
  PART 1 — Storage & Monitoring
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

  User ──► Upload Files ──► S3 Bucket
                            (no public access)
                                 │
                            CloudTrail
                          (data events)
                                 │
                          CloudWatch Logs
                        (PutObject events)

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
  PART 2 — Compute & Load Balancing
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

         Internet / Client
                │
                ▼
   ┌─────────────────────────┐
   │  Application Load       │  ◄── Only public IP exposed
   │  Balancer  (ALB)        │
   └────────┬────────┬───────┘
            │        │  Round-robin
            ▼        ▼
      ┌──────────┐ ┌──────────┐
      │  EC2 #1  │ │  EC2 #2  │  ◄── Private, not directly
      │ Apache   │ │ Apache   │       accessible
      └──────────┘ └──────────┘
```

---

## 🛠️ Tech Stack

| Service | Purpose |
|---------|---------|
| ![S3](https://img.shields.io/badge/S3-569A31?style=flat&logo=amazons3&logoColor=white) **Amazon S3** | Private object storage |
| ![CloudTrail](https://img.shields.io/badge/CloudTrail-FF4F8B?style=flat&logo=amazonaws&logoColor=white) **AWS CloudTrail** | API-level audit logging |
| ![CloudWatch](https://img.shields.io/badge/CloudWatch-FF4F8B?style=flat&logo=amazonaws&logoColor=white) **AWS CloudWatch** | Log monitoring & search |
| ![EC2](https://img.shields.io/badge/EC2-FF9900?style=flat&logo=amazonec2&logoColor=white) **Amazon EC2** | Virtual web servers |
| ![ALB](https://img.shields.io/badge/ALB-FF9900?style=flat&logo=amazonaws&logoColor=white) **Application Load Balancer** | Traffic distribution |

---

## 📦 Part 1 — S3 Bucket + CloudWatch Logging

### ⚙️ Bucket Configuration

| Setting | Value |
|---------|-------|
| Bucket Name | `my-task3-bucket-2026` |
| Region | `ap-south-2` — Asia Pacific (Hyderabad) |
| Public Access | 🔒 **Blocked — all 4 settings ON** |
| Versioning | Disabled |
| Encryption | SSE-S3 (AWS managed keys) |
| ACLs | Disabled (bucket owner enforced) |

### 🔢 Steps Performed

**Step 1 — Create the bucket**
```
S3 → Create bucket → Enter name → Block all public access → Create
```

**Step 2 — Upload files**
```
Open bucket → Upload → Add files → Upload
```

**Step 3 — Enable CloudTrail with S3 data events**
```
CloudTrail → Create trail → Enable S3 data events → Select bucket
```

**Step 4 — Connect to CloudWatch**
```
CloudTrail → CloudWatch Logs → Create Log Group: /aws/s3/task3
```

**Step 5 — Verify logs**
```
Upload a file → CloudWatch → Log Groups → /aws/s3/task3 → Find PutObject event
```

---

## 🖥️ Part 2 — EC2 Instances + Application Load Balancer

### ⚙️ EC2 Configuration

| Setting | Value |
|---------|-------|
| AMI | Amazon Linux 2023 |
| Instance Type | `t2.micro` (Free Tier) |
| Instances | `web-server-1`, `web-server-2` |
| Security Group | HTTP port `80` (from ALB only), SSH port `22` |
| Web Server | Apache (httpd) |

### 📜 User Data Bootstrap Script

> Applied to both EC2 instances on launch — auto-installs Apache with no manual SSH needed.

```bash
#!/bin/bash
yum update -y
yum install -y httpd
systemctl start httpd
systemctl enable httpd
echo "<h1>Hello from EC2 Instance 1 - $(hostname -f)</h1>" > /var/www/html/index.html
```

> ⚠️ Change `Instance 1` → `Instance 2` for the second server.

### ⚙️ Load Balancer Configuration

| Setting | Value |
|---------|-------|
| Type | Application Load Balancer (ALB) |
| Scheme | Internet-facing |
| Listener | HTTP — Port `80` |
| Target Group | Both EC2 instances registered |
| Health Check | `GET /` — expects HTTP 200 |
| Distribution | Round-robin (default) |

### 🔢 Steps Performed

**Step 1 — Launch EC2 instances**
```
EC2 → Launch Instance → Amazon Linux 2023 → t2.micro
→ Add User Data script → Launch (repeat for Instance 2)
```

**Step 2 — Create Target Group**
```
EC2 → Target Groups → Create → Instance type → HTTP port 80
→ Register both EC2 instances → Health check path: /
```

**Step 3 — Create Load Balancer**
```
EC2 → Load Balancers → Create → Application Load Balancer
→ Internet-facing → Select 2 subnets (2 AZs minimum)
→ Add HTTP listener → Forward to Target Group → Create
```

**Step 4 — Verify**
```
Copy ALB DNS → Open in browser → See Instance 1 response
→ Refresh → See Instance 2 response (round-robin confirmed)
```

---

## 📸 Screenshots

### Part 1 — S3 + CloudWatch

| # | Screenshot | Description |
|---|-----------|-------------|
| 1 | ![](3a/1-s3-bucket-created.png) | S3 bucket created successfully |
| 2 | ![](3a/2-s3-bucket-private.png) | Block all public access enabled |
| 3 | ![](3a/3-s3-files-uploaded.png) | Files uploaded to the bucket |
| 4 | ![](3a/4-cloud-trail.png) | CloudTrail configured with S3 data events |
| 5 | ![](3a/5-cloudwatch-log-groups.png) | CloudWatch log group created |
| 6 | ![](3a/6-cloudwatch-putobject-logs.png) | PutObject events visible in CloudWatch |

### Part 2 — EC2 + ALB

| # | Screenshot | Description |
|---|-----------|-------------|
| 1 | ![](1-eC2-instances.png) | Both EC2 instances in running state |
| 2 | ![](2-target-group-healthy.png) | Target group — both instances healthy |
| 3 | ![](3-alb.png) | ALB active with DNS name |
| 4 | ![](4-alb-dns-output-instance1.png) | ALB DNS → Instance 1 response |
| 5 | ![](5-alb-dns-output-instance2.png) | ALB DNS → Instance 2 response (round-robin) |
| 6 | ![](6-EC2-direct-access-blocked.png) | Direct EC2 IP access blocked |
| 7 | ![](7-security-group-rules.png) | Security group rules configured |

---

## 💡 Key Learnings

### 🔒 Security
- S3 **Block all public access** prevents accidental data exposure — all 4 settings work independently and must all be ON for full protection
- EC2 instances should **never** be directly internet-accessible when behind a load balancer — the ALB is the only public endpoint

### 📊 Monitoring
- **CloudTrail** captures every API call at the AWS infrastructure level — who did what, when, and from where
- **CloudWatch** makes those logs searchable and allows setting alarms on specific events like unauthorized access

### ⚖️ Load Balancing
- The ALB performs **round-robin** distribution by default — traffic alternates evenly across healthy instances
- **Health checks** run every 30 seconds — unhealthy instances are automatically removed from rotation without any manual intervention
- The client always sees the **ALB's IP**, not the EC2 IP — this hides backend infrastructure from the internet

---

## 📁 Folder Structure

```
AWS-Task-3/
│
├── 📁 3a/                            ← Part 1 screenshots (S3 + CloudWatch)
│   ├── 1-s3-bucket-created.png
│   ├── 2-s3-bucket-private.png
│   ├── 3-s3-files-uploaded.png
│   ├── 4-cloud-trail.png
│   ├── 5-cloudwatch-log-groups.png
│   └── 6-cloudwatch-putobject-logs.png
│
├── 🖼️ 1-eC2-instances.png            ← Part 2 screenshots (EC2 + ALB)
├── 🖼️ 2-target-group-healthy.png
├── 🖼️ 3-alb.png
├── 🖼️ 4-alb-dns-output-instance1.png
├── 🖼️ 5-alb-dns-output-instance2.png
├── 🖼️ 6-EC2-direct-access-blocked.png
├── 🖼️ 7-security-group-rules.png
│
└── 📄 README.md
```

---

## 👤 Author

| Field | Info |
|-------|------|
| Name | Your Name |
| Course | DevOps Assignments |
| Task | AWS Task 3 |
| Region | ap-south-2 (Hyderabad) |
| Date | May 2026 |

---

<div align="center">

**⭐ If this helped you, give the repo a star!**

![AWS](https://img.shields.io/badge/Built_with-AWS-FF9900?style=for-the-badge&logo=amazonaws&logoColor=white)

</div>
