AWS Task 2 - VPC and EC2 Setup

================================



WHAT THIS PROJECT IS ABOUT

\----------------------------

This project demonstrates how to set up a secure cloud network on AWS

from scratch and launch a Linux server inside it using the AWS Console.



This is the foundation of real-world cloud infrastructure used by companies

like Netflix, Swiggy, Zomato, and thousands of others running on AWS.





WHAT I BUILT

\-------------

Internet

&#x20;   |

&#x20;   v

Internet Gateway         - the front door to the internet

&#x20;   |

&#x20;   v

VPC (10.0.0.0/16)        - my own private cloud network

&#x20;   |

&#x20;   |-- Public Subnet (10.0.1.0/24)   - 256 IPs, faces the internet

&#x20;   |        |

&#x20;   |        -- EC2 Linux Instance    - my live cloud server

&#x20;   |

&#x20;   |-- Private Subnet (10.0.2.0/24)  - 256 IPs, hidden from internet





AWS SERVICES USED

\------------------

AWS VPC          - Created a private isolated network in the cloud

Internet Gateway - Connected the VPC to the public internet

Public Subnet    - A zone inside the VPC visible to the internet

Private Subnet   - A zone inside the VPC hidden from the internet

Route Table      - Rules that direct traffic to the right places

Security Group   - Firewall that controls who can access the EC2

AWS EC2          - A real Linux server launched inside the network





NETWORK CONFIGURATION

\----------------------

VPC CIDR              : 10.0.0.0/16

Public Subnet CIDR    : 10.0.1.0/24  (256 IP addresses)

Private Subnet CIDR   : 10.0.2.0/24  (256 IP addresses)

EC2 Operating System  : Amazon Linux 2023

EC2 Instance Type     : t3.micro





SECURITY GROUP RULES

\---------------------

SSH access   - TCP - Port 22 - Source 0.0.0.0/0

HTTP access  - TCP - Port 80 - Source 0.0.0.0/0





STEPS I FOLLOWED

\-----------------

Step 1 - Created the VPC

&#x20; - CIDR block: 10.0.0.0/16

&#x20; - Enabled DNS support and hostnames



Step 2 - Created the Internet Gateway

&#x20; - Created IGW and attached it to the VPC

&#x20; - This allows internet traffic to flow in and out



Step 3 - Created Public Subnet

&#x20; - CIDR: 10.0.1.0/24 which gives 256 IP addresses

&#x20; - Enabled auto-assign public IP



Step 4 - Created Private Subnet

&#x20; - CIDR: 10.0.2.0/24 which gives 256 IP addresses

&#x20; - No internet access, internal traffic only



Step 5 - Set Up Route Table

&#x20; - Created a public route table

&#x20; - Added route: 0.0.0.0/0 pointing to Internet Gateway

&#x20; - Associated the public subnet to this route table



Step 6 - Launched EC2 Instance

&#x20; - AMI: Amazon Linux 2023

&#x20; - Instance type: t3.micro

&#x20; - Placed inside the VPC and public subnet

&#x20; - Created security group allowing SSH (22) and HTTP (80)

&#x20; - Connected via SSH from Windows CMD





HOW TO CONNECT TO EC2

\-----------------------

Open CMD and type:

ssh -i my-key.pem ec2-user@YOUR-PUBLIC-IP





SCREENSHOTS

\------------

01 - 01-vpc-created.png            - VPC created with CIDR 10.0.0.0/16

02 - 02-internet-gateway.png       - IGW attached to VPC

03 - 03-public-subnet.png          - Public subnet with 256 IPs

04 - 04-private-subnet.png         - Private subnet with 256 IPs

05 - 05-route-table-routes.png     - Route table with 0.0.0.0/0 to IGW

06 - 06-route-table-association.png- Public subnet linked to route table

07 - 07-ec2-running.png            - EC2 instance in running state

08 - 08-ec2-details.png            - EC2 showing VPC and subnet details

09 - 09-ssh-connected.png          - SSH login from Windows CMD





WHAT I LEARNED

\---------------

\- How to create and configure a VPC (Virtual Private Cloud)

\- The difference between public and private subnets

\- How an Internet Gateway connects a VPC to the internet

\- How route tables control where network traffic goes

\- How security groups act as firewalls for EC2 instances

\- How to launch a Linux EC2 instance inside a custom network

\- How to SSH into a cloud server from Windows CMD





WHY THIS MATTERS

\-----------------

Every application running in the cloud, whether it is a startup or a large

company, is built on top of this exact infrastructure.

VPC + Subnets + EC2 is the starting point for all real-world cloud deployments.





Submitted as part of AWS Cloud Infrastructure Training - Task 2

