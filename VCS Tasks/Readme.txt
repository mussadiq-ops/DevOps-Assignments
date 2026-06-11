````md
<div align="center">

# 🚀 My DevOps Scripts — VCS Task

### Beginner-Friendly Git, GitHub & Shell Scripting Project

<img src="https://img.shields.io/badge/Shell-Bash-green?style=for-the-badge&logo=gnu-bash">
<img src="https://img.shields.io/badge/Git-Version_Control-orange?style=for-the-badge&logo=git">
<img src="https://img.shields.io/badge/GitHub-Repository-black?style=for-the-badge&logo=github">
<img src="https://img.shields.io/badge/Platform-WSL%20%7C%20Linux-blue?style=for-the-badge">

---

### 📌 Objective
This repository was created as part of a **Version Control System (VCS) Task** to practice:

✅ Git Repository Creation  
✅ Branching Strategy  
✅ Merge (Fast-Forward & Three-Way)  
✅ Rebase Workflow  
✅ Git Stash Operations  
✅ GitHub Integration using WSL + Git

</div>

---

# 📂 Project Structure

```bash
my-devops-scripts/
│── backup.sh
│── cleanup.sh
│── deploy.sh
│── hello.sh
│── monitor.sh
│── sysinfo.sh
│── README.md
````

---

# 🛠️ Tech Stack Used

| Technology      | Purpose                      |
| --------------- | ---------------------------- |
| 🐧 Bash / Shell | Script automation            |
| 🌿 Git          | Version control              |
| 🐙 GitHub       | Remote repository            |
| 🖥️ WSL         | Linux environment on Windows |

---

# 📜 Shell Scripts Included

## 👋 hello.sh

A basic greeting script.

```bash
./hello.sh
```

### Output

```bash
Hello, World!
```

---

## 💻 sysinfo.sh

Displays system information.

```bash
./sysinfo.sh
```

### Shows:

* Hostname
* OS Details
* Uptime

---

## 🧹 cleanup.sh

Simulates cleanup operations.

```bash
./cleanup.sh
```

### Purpose:

Used to understand shell automation basics.

---

## 💾 backup.sh

Simulates backup creation.

```bash
./backup.sh
```

### Features:

* Creates backup directory
* Generates timestamp
* Simulates backup process

---

## 📊 monitor.sh

Displays system resource usage.

```bash
./monitor.sh
```

### Tracks:

* CPU Usage
* RAM Usage
* Disk Usage

---

## 🚀 deploy.sh

Simulates deployment process.

```bash
./deploy.sh
```

### Workflow:

* Creates deployment directory
* Simulates application deployment
* Prints deployment success message

---

# 🌿 Git Workflow Practiced

## 1️⃣ Repository Setup

```bash
git init
git add .
git commit -m "Initial commit"
git remote add origin <repo-url>
git push -u origin main
```

### Learned:

✔ Local → Remote Git workflow
✔ GitHub repository setup
✔ First push to GitHub

---

## 2️⃣ Fast Forward Merge

```bash
git merge feature/add-backup-script
```

### What Happens?

Git moves the branch pointer forward without creating a merge commit.

### Real World Example

A developer adds a small feature without conflicts.

---

## 3️⃣ Three-Way Merge

```bash
git merge feature/add-monitor-script --no-ff
```

### What Happens?

Git creates a **merge commit** to preserve branch history.

### Real World Example

Multiple developers work on separate features simultaneously.

---

## 4️⃣ Rebase

```bash
git rebase main
```

### What Happens?

Git replays feature branch commits on top of the latest `main`.

### Benefits:

✅ Cleaner history
✅ Linear commit graph
✅ Easier debugging

---

## 5️⃣ Stash

```bash
git stash
git stash list
git stash pop
```

### What Happens?

Temporarily saves unfinished work without committing.

### Real World Example

Urgent production bug appears → temporarily save work → fix issue → continue later.

---

# 📸 Task Screenshots

The following screenshots are maintained inside:

```bash
DevOps-Assignments/VCS-Task/
```

Includes:

* Git setup
* Push to GitHub
* Merge operations
* Rebase
* Stash workflow
* Final commit history

---

# 📚 Key Learnings

By completing this task, I learned:

✅ Git basics & repository creation
✅ Branching & collaboration workflow
✅ Fast-forward merge
✅ Three-way merge (`--no-ff`)
✅ Rebase workflow
✅ Stash operations
✅ GitHub push & authentication using token
✅ Real-world DevOps version control practices

---

# 🌍 Real World DevOps Use Cases

| Concept   | Real Usage           |
| --------- | -------------------- |
| Branching | Feature development  |
| Merge     | Code integration     |
| Rebase    | Clean commit history |
| Stash     | Emergency bug fixes  |
| GitHub    | CI/CD integrations   |

---

<div align="center">

## ⭐ If you found this useful, feel free to star the repository!

### Built with ❤️ using Git + Bash + WSL

**Author:** Mussadiq

</div>
```
