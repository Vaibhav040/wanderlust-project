# 🏗 Infrastructure as Code: AWS Cluster Provisioning

This directory contains the **Terraform** configuration used to architect the host environment for the Wanderlust Mega Project. 

## 🌟 Professional Highlights
- **State Management:** Implemented **Remote State Storage** using an S3 Bucket.
- **Concurrency Control:** Utilized **DynamoDB** for State Locking to prevent concurrent execution conflicts.
- **Automated Provisioning:** Integrated a `user_data` bootstrap script to fully configure the instance upon launch.

## 🛠 Infrastructure Specifications
- **Cloud Provider:** AWS
- **AMI:** Ubuntu 22.04 LTS
- **Instance Type:** `c7i-flex.large` (Optimized for Kubernetes/Minikube workloads)
- **Networking:** Custom Security Group with the following ingress rules:
  - `22`: SSH Management
  - `80`: Nginx Reverse Proxy (Production Traffic)
  - `8080`, `8081`, `5173`: Application & Development Ports
  - `31000`, `31100`, `32520`: Kubernetes NodePorts / Service Access

## 🚀 Bootstrapping (user_data)
Upon deployment, the instance automatically executes a script to:
1. Update system packages.
2. Install and enable the **Docker** engine.
3. Install **Minikube** and **kubectl**.
4. Configure environment permissions for immediate DevOps operations.

## 📋 Deployment Guide

1. **Backend Configuration:**
  Ensure your S3 bucket and DynamoDB table names are correctly set in `provider.tf` or `backend.tf`.
   Stage 1: Backend Setup

   Navigate to the backend-setup directory.

   Run  terraform init and then terraform plan and then terraform apply to create the S3 Bucket (State Storage) and DynamoDB Table (State Locking).

   This is a one-time setup to prepare the "Remote Backend."

2. **Initialize & Sync State:**
   ```bash
   Once the backend is initialized, navigating to the environment folder and running terraform init will automatically detect the remote S3 backend.

   All subsequent terraform plan and apply actions will sync the .tfstate file directly to the S3 bucket, secured by DynamoDB locking.