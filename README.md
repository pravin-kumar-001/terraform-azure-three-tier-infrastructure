Enterprise Azure Infrastructure Architecture – Technical Explanation

This project follows a Production-Ready Enterprise Modular Infrastructure as Code (IaC) Architecture built on Microsoft Azure using Terraform Parent-Child Modules. The infrastructure is designed to be reusable, scalable, and environment-independent by maintaining separate configurations for Development and Production.

1. Overall Architecture


                           Internet
                               │
                               ▼
                     Azure Public IP (Standard)
                               │
                               ▼
                  Azure Application Gateway (L7)
                               │
                 ┌─────────────┴─────────────┐
                 │                           │
                 ▼                           ▼
        VM01 (Frontend)              VM02 (Backend)
                                             │
                                             ▼
                                     VM03 (Database)
                           

Administrative access

Administrator
      │
      ▼
Azure Bastion
      │
      ▼
Virtual Network
      │
      ▼
SSH Access to Linux Virtual Machines

2. Infrastructure Design Pattern

The infrastructure follows a Modular Parent-Child Module Architecture.

Root Module
      │
      ├── Resource Group Module
      ├── Storage Account Module
      ├── Virtual Network Module
      ├── Subnet Module
      ├── Public IP Module
      ├── Network Interface Module
      ├── Network Security Group Module
      ├── NIC-NSG Association Module
      ├── Linux Virtual Machine Module
      ├── Azure Bastion Module
      └── Azure Application Gateway Module

Each module is completely independent and reusable. The Root Module orchestrates the deployment by passing variables and module outputs between child modules.

3. Network Topology

Resource Group
       │
       ▼
Virtual Network
       │
 ┌─────┼────────────────────────────┐
 │     │                            │
 ▼     ▼                            ▼
VM Subnet                AzureBastionSubnet     ApplicationGatewaySubnet

The Virtual Network contains dedicated subnets for:

Virtual Machines
Azure Bastion
Azure Application Gateway

This follows Azure networking best practices by isolating infrastructure components into separate subnets.

4. Compute Layer

The compute layer consists of three Linux Virtual Machines.

VM01
Frontend Web Server
Receives requests from Application Gateway
Hosts the client-facing application

VM02
Backend Application Server
Hosts REST APIs or business services
Processes requests coming from the frontend

VM03
Database Server
Hosts MySQL
Accepts connections only from the backend application

This separation represents a standard Three-Tier Application Architecture.

5. Traffic Flow

Client
   │
   ▼
Public IP
   │
   ▼
Azure Application Gateway
   │
   ├────────► Frontend VM
   │
   └────────► Backend VM
                     │
                     ▼
              Database VM

Application Gateway acts as the single public entry point for the application.

The Database VM is never exposed directly to the Internet.

6. Administrative Access

Administrative connectivity follows Azure security best practices.

Administrator
      │
      ▼
Azure Bastion
      │
      ▼
Linux Virtual Machines

No Virtual Machine is assigned a Public IP address.

SSH connectivity is established only through Azure Bastion.

This significantly reduces the attack surface.

7. Network Security

Each Virtual Machine is protected by its own Network Security Group.

Frontend NSG

Allows

SSH (22)
HTTP (80)
HTTPS (443)

Backend NSG

Allows

SSH (22)
HTTP (80)
HTTPS (443)

Database NSG

Allows
SSH (22)
MySQL (3306)

Ideally, port 3306 should be restricted to the Backend VM or Backend Subnet instead of allowing access from all sources.

8. Application Delivery

Azure Application Gateway provides

Layer-7 Load Balancing
HTTP Routing
Health Probes
Backend Health Monitoring
Request Routing

The backend pool dynamically receives private IP addresses from the deployed Linux Virtual Machines.

ip_addresses = [

  for vm_key in each.value.backend_vm_keys :

  var.linux_virtual_machines[vm_key].private_ip_address

]

This eliminates hardcoded IP addresses and improves scalability.

9. Terraform Architecture

The project follows a reusable Terraform design.

Features include:

Parent-Child Modules
Reusable Modules
for_each
Nested Maps
Dynamic Blocks
Lookup Functions
Ternary Operators
Data Sources
Module Outputs
Module Dependencies

This minimizes code duplication and allows new infrastructure to be provisioned by updating only the environment configuration.

10. Environment Separation

Separate environments are maintained.

environments/

├── dev/
└── prod/

Each environment has its own

terraform.tfvars
variables
backend configuration
deployment values

while sharing the same reusable modules.

11. Infrastructure State Management

Terraform State is stored remotely in an Azure Storage Account.

Benefits include:

Centralized state management
State locking
Team collaboration
Version consistency
Secure storage
12. Dependency Management

Deployment dependencies are handled using module outputs and explicit module dependencies.

Example:

module "application_gateway" {

  ...

  depends_on = [
    module.linux_virtual_machine,
    module.public_ip,
    module.subnet
  ]

}

This guarantees that dependent infrastructure components are created in the correct order.

13. Infrastructure Security

Security controls implemented include:

Azure Bastion for secure administrative access
Dedicated Network Security Groups
Private IP communication between internal resources
No Public IP assigned to Virtual Machines
Managed Identity for Linux Virtual Machines
Common tagging strategy for governance and cost management
14. Scalability

The infrastructure is designed for horizontal scalability.

Adding a new Virtual Machine typically requires only updating the environment configuration.

Example:

terraform.tfvars

↓

Add VM Definition

↓

terraform plan

↓

terraform apply

No module code modifications are required because all resources are deployed using for_each.

15. Architecture Classification

From an enterprise infrastructure perspective, this solution can be classified as:

Production-Ready Azure Infrastructure
Three-Tier Enterprise Architecture
Modular Infrastructure as Code (IaC)
Reusable Parent-Child Terraform Module Architecture
Enterprise Azure Landing Zone–Aligned Infrastructure (aligned with landing zone principles, though not a complete Azure Landing Zone implementation)
Environment-Based Multi-Stage Deployment Architecture
Secure Azure Network Architecture
Scalable Cloud Infrastructure Design

This architecture reflects common enterprise practices by emphasizing modularity, reusability, secure network segmentation, environment separation, and automated infrastructure provisioning through Terraform.
