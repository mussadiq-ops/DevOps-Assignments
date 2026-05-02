\# AWS Task 1 - Windows EC2 with RDP



\## What I Did

Created a Windows Virtual Machine on AWS EC2 and

connected to it remotely using RDP, then ran

system commands in CMD.



\## Tech Stack

\- AWS EC2 (Windows Server 2022)

\- RDP (Remote Desktop Protocol)

\- Windows CMD



\## Steps Followed

1\. Launched EC2 instance (Windows Server 2022, t2.micro)

2\. Created Key Pair for password decryption

3\. Configured Security Group - opened Port 3389 for RDP

4\. Decrypted Administrator password using .pem file

5\. Connected via Remote Desktop Connection (mstsc)

6\. Ran systeminfo, ipconfig, winver in CMD



\## Screenshots

!\[EC2 Running](screenshots/01\_ec2\_running.png)

!\[RDP Connected](screenshots/02\_rdp\_connected.png)

!\[System Info](screenshots/03\_systeminfo.png)

!\[IP Config](screenshots/04\_ipconfig.png)

!\[Windows Version](screenshots/05\_winver.png)



\## What I Learned

\- Cloud Computing basics with AWS

\- How Virtual Machines work

\- Security Groups and Port configuration

\- Remote Desktop Protocol (RDP)

\- Basic Windows CMD commands

