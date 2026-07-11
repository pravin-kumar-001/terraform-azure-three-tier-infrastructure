# Enterprise Azure Infrastructure Architecture – Technical Explanation

## 1. Architecture Overview

This project follows a **Production-Ready Enterprise Infrastructure as Code (IaC) Architecture** built on Microsoft Azure using Terraform. The infrastructure is designed using a modular Parent-Child Module approach, where each Azure resource is implemented as an independent reusable Terraform module. The same modules are reused across Development and Production environments by supplying different configuration values through environment-specific Terraform variable files.

The overall architecture follows a **Three-Tier Application Architecture**, consisting of a Presentation Layer (Frontend), Business Layer (Backend), and Data Layer (Database). Network security, scalability, and modularity have been considered throughout the infrastructure design.

---

## 2. Infrastructure Components

The infrastructure consists of the following Azure services:

* Resource Group
* Storage Account (Terraform Remote Backend)
* Virtual Network
* Subnets
* Public IP
* Network Security Groups
* Network Interfaces
* Linux Virtual Machines
* Azure Bastion
* Azure Application Gateway

Each resource is deployed through its own Terraform module, making the infrastructure reusable and easier to maintain.

---

## 3. Infrastructure Design Pattern

The infrastructure follows a Parent-Child Module Architecture.

Root Module

↓
Resource Group Module

↓
Storage Account Module

↓
Virtual Network Module

↓
Subnet Module

↓
Public IP Module

↓
Network Interface Module

↓
Network Security Group Module

↓
NIC-NSG Association Module

↓
Linux Virtual Machine Module

↓
Azure Bastion Module

↓
Azure Application Gateway Module

The Root Module orchestrates the complete deployment by invoking child modules, passing variables, and consuming module outputs.

---

## 4. Network Topology

The infrastructure is deployed inside a single Azure Virtual Network.

The Virtual Network contains multiple dedicated subnets.

* VM Subnet
* AzureBastionSubnet
* ApplicationGatewaySubnet

Each subnet hosts a specific Azure service to maintain proper network segmentation and follow Azure networking best practices.

---

## 5. Compute Layer

The compute layer consists of three Linux Virtual Machines.

### VM01 – Frontend Server

The Frontend Virtual Machine hosts the web application that directly serves client requests. It receives incoming traffic from Azure Application Gateway over HTTP or HTTPS.

### VM02 – Backend Server

The Backend Virtual Machine hosts the application logic and REST APIs. Requests from the Frontend server are forwarded to the Backend server for processing.

### VM03 – Database Server

The Database Virtual Machine hosts the MySQL database. It stores application data and accepts connections only from the Backend server. The database server is never exposed directly to the Internet.

This separation represents a standard Enterprise Three-Tier Architecture.

---

## 6. Application Traffic Flow

The client accesses the application through the public endpoint of Azure Application Gateway.

Internet

↓

Azure Public IP

↓

Azure Application Gateway

↓

Frontend Virtual Machine

↓

Backend Virtual Machine

↓

Database Virtual Machine

Azure Application Gateway acts as the single entry point to the application and distributes requests to the backend servers using private IP addresses.

---

## 7. Administrative Access

Administrative access is secured using Azure Bastion.

Administrator

↓

Azure Bastion

↓

Linux Virtual Machines

None of the Linux Virtual Machines are assigned a Public IP address.

All SSH connections are established through Azure Bastion, significantly reducing the attack surface and improving overall infrastructure security.

---

## 8. Network Security

Each Virtual Machine is protected by a dedicated Network Security Group.

### Frontend NSG

* SSH (22)
* HTTP (80)
* HTTPS (443)

### Backend NSG

* SSH (22)
* HTTP (80)
* HTTPS (443)

### Database NSG

* SSH (22)
* MySQL (3306)

The database server should ideally allow MySQL traffic only from the Backend server or Backend subnet instead of accepting traffic from all sources.

---

## 9. Azure Application Gateway

Azure Application Gateway is deployed as the Layer-7 Load Balancer.

Its responsibilities include:

* Receiving incoming client requests
* Routing traffic to backend virtual machines
* Performing health probes
* Monitoring backend health
* Forwarding requests only to healthy backend instances

The backend pool dynamically receives the private IP addresses of the Linux Virtual Machines through Terraform outputs instead of using hardcoded IP addresses.

This design improves scalability and reduces manual configuration.

---

## 10. Azure Bastion

Azure Bastion provides secure browser-based SSH connectivity to Linux Virtual Machines.

Key benefits include:

* No Public IP required on Virtual Machines
* Secure administrative access
* Reduced attack surface
* Centralized management access

---

## 11. Terraform Module Design

The project is developed using reusable Terraform modules.

Key Terraform concepts used include:

* Parent-Child Modules
* Reusable Modules
* for_each
* Nested Maps
* Dynamic Blocks
* Lookup Functions
* Ternary Operators
* Module Outputs
* Input Variables
* Data Sources
* Module Dependencies

This design minimizes code duplication and improves maintainability.

---

## 12. Environment Separation

The project maintains separate Development and Production environments.

environments/

├── dev/

└── prod/

Each environment contains its own:

* terraform.tfvars
* variables
* backend configuration
* deployment parameters

Both environments consume the same reusable Terraform modules.

---

## 13. Terraform State Management

Terraform state is stored remotely in an Azure Storage Account.

Advantages include:

* Centralized state management
* Team collaboration
* State locking
* Improved consistency
* Secure remote storage

Remote state management enables multiple engineers to work on the same infrastructure without conflicts.

---

## 14. Dependency Management

Terraform module dependencies are managed using module outputs and explicit module dependencies.

For example, the Azure Application Gateway module depends on:

* Linux Virtual Machine Module
* Public IP Module
* Subnet Module

This guarantees that dependent infrastructure resources are provisioned in the correct sequence during deployment.

---

## 15. Infrastructure Security

The infrastructure implements several enterprise security practices.

* Azure Bastion for secure administration
* Dedicated Network Security Groups
* Private IP communication between internal resources
* No Public IP on Virtual Machines
* System Assigned Managed Identity
* Common tagging strategy
* Network segmentation through dedicated subnets

These controls improve the security posture of the overall environment.

---

## 16. Scalability

The infrastructure is designed for horizontal scalability.

Because every module uses reusable Terraform code with for_each, new infrastructure components can be added by updating only the environment configuration.

No modifications to the module source code are required.

This significantly simplifies future infrastructure expansion.

---

## 17. Architecture Classification

From an enterprise cloud perspective, this infrastructure can be classified as:

* Production-Ready Azure Infrastructure
* Three-Tier Enterprise Architecture
* Modular Infrastructure as Code (IaC)
* Parent-Child Terraform Module Architecture
* Enterprise Azure Landing Zone–Aligned Infrastructure
* Environment-Based Multi-Stage Deployment Architecture
* Secure Azure Network Architecture
* Scalable Cloud Infrastructure

Overall, this architecture follows enterprise cloud engineering principles by emphasizing modularity, reusability, automation, security, scalability, and environment isolation while leveraging Terraform as the Infrastructure as Code platform.
