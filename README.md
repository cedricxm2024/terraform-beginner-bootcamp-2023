# Cedric’s Terraform-Managed Game Website

This repository demonstrates a complete Infrastructure-as-Code (IaC) setup using Terraform to deploy a static Tic Tac Toe game website on AWS S3, served via CloudFront. The goal is to showcase full DevOps proficiency: designing, implementing, and documenting cloud infrastructure in a professional, modular, and reproducible manner.

🚀 Project Overview

Infrastructure as Code (IaC): All AWS resources are provisioned and managed using Terraform.

Terraform Cloud Backend: The repository is configured to use Terraform Cloud as the backend, with auto-apply enabled so that any changes committed to Git are automatically applied. This ensures continuous deployment and versioned infrastructure.

Static Website Hosting: The Tic Tac Toe game is hosted on an S3 bucket, distributed via a CloudFront CDN for low-latency global access.

Modular Design: Reusable Terraform modules are used to structure the project for maintainability and scalability.

Semantic Versioning: The project uses Semantic Versioning (MAJOR.MINOR.PATCH) to manage releases and track infrastructure changes consistently.

Version Control Best Practices: All branches are preserved to provide a transparent history of changes and incremental development.

Reproducible Development Environments: Configured with Gitpod and VS Code Dev Containers for consistent environments across machines.

📂 Repository Structure
.
 main.tf            # Root Terraform configuration and module calls
 variables.tf       # Input variables for Terraform
 outputs.tf         # Outputs from Terraform (S3 bucket info, CloudFront domain)
 providers.tf       # Terraform provider configuration (AWS & Random)
 modules/video_game/    # Module containing S3, CloudFront, and static website logic
public/index.html     # Tic Tac Toe game
   └── error.html     # Error page for the site
.gitpod.yml        # Gitpod automation for installing Terraform & AWS CLI
.gitignore         # Ignore Terraform state files, overrides, and sensitive data
README.md          # This file

🛠 Architecture & Implementation
1. Terraform Modules

The modules/video_game directory contains all Terraform code for provisioning the static website infrastructure.

Why modules?

Reusability: Modules can be reused across multiple projects or environments.

Maintainability: Changes in infrastructure logic only need to be updated in one place.

Scalability: Modular design allows adding new resources or environments without rewriting code.

Terraform Module Best Practices

2. Terraform Cloud Backend

The repository uses Terraform Cloud as the backend (terraform { cloud { ... } }) to store state remotely and securely.

Auto-apply is enabled, so every commit pushed to Git triggers an automatic application of infrastructure changes.

This configuration supports Continuous Deployment for Infrastructure, ensures state consistency, and allows collaboration in team environments.

Terraform Cloud Documentation

3. AWS Resources

The module provisions the following AWS resources:

S3 Bucket

Hosts the static Tic Tac Toe game files (index.html, error.html).

Configured for public read access via CloudFront.

Versioned and securely managed using Terraform.

CloudFront Distribution

Provides a globally distributed CDN for fast website access.

Integrates with the S3 bucket as the origin.

Handles error responses (e.g., error.html for missing pages).

Outputs

bucket_id and bucket_name for identification.

cloudfront_domain_name to access the deployed website.

Hosting a Static Website on AWS with Terraform

4. Root Terraform Files

main.tf: Calls the video_game module and passes user-specific variables.

variables.tf: Defines the user_uuid input variable with validation.

outputs.tf: Exposes key information from the module.

providers.tf: Configures the required Terraform providers (AWS & Random).

5. Development Environment

.gitpod.yml ensures Terraform and AWS CLI are installed automatically in a consistent cloud development environment.

VS Code extensions configured for Terraform and AWS toolkit for efficient local editing.

.gitignore follows Terraform best practices to prevent sensitive data or state files from being committed.

Terraform CI/CD & Environment Best Practices

🎮 Website Details

The project hosts a fully playable Tic Tac Toe game:

Written in pure HTML, CSS, and JavaScript.

Interactive board with restart functionality.

Displays the current player, winner, or tie status.

Custom error page to handle failed requests.

Demonstrates the ability to deploy a static website with a game that is globally accessible via CloudFront.

🌟 DevOps Highlights

All Infrastructure Managed in Terraform

Every AWS resource is declared as code.

Ensures reproducible deployments across environments.

Terraform Cloud Backend

Stores state securely and centrally.

Auto-apply ensures continuous deployment whenever changes are committed.

Branch Retention

All branches are preserved intentionally.

Provides transparency into incremental changes.

Reflects real-world team scenarios where history and review are critical.

Managing Terraform in Team Environments

Semantic Versioning

Infrastructure changes and releases follow MAJOR.MINOR.PATCH versioning to maintain clarity, backward compatibility, and professional release management.

Validation and Standards

Input validation for user_uuid ensures correct formatting.

Terraform version constraints enforce compatibility.

Gitignore excludes sensitive files and state.

⚡ How to Deploy

Clone the repository.

Initialize Terraform:

terraform init


Review the plan:

terraform plan


Apply the infrastructure (or rely on Terraform Cloud auto-apply):

terraform apply


Access your static website via the cloudfront_domain_name output.

📚 References & Resources

Terraform Official Documentation- https://developer.hashicorp.com/terraform/docs

AWS S3 Static Website Hosting- https://docs.aws.amazon.com/AmazonS3/latest/userguide/WebsiteHosting.html

AWS CloudFront CDN- https://docs.aws.amazon.com/AmazonCloudFront/latest/DeveloperGuide/Introduction.html

Terraform Module Best Practices- https://devopscube.com/terraform-module-best-practices/

Terraform Branching & Environment Management- https://www.gruntwork.io/blog/how-to-manage-multiple-environments-with-terraform-using-branches?utm_source=chatgpt.com

Terraform Cloud Documentation- https://developer.hashicorp.com/terraform/cloud-docs

Semantic Versioning- https://semver.org/

✅ Why This Repository Matters

This project is a full demonstration of DevOps capability:

Shows understanding of Terraform for IaC with modules.

Implements a real-world AWS architecture (S3 + CloudFront) for a static website.

Uses Terraform Cloud backend with auto-apply to enable continuous deployment.

Demonstrates branch management and version control discipline.

Uses Semantic Versioning for structured releases.

Includes reproducible development environments for contributors.

Highlights professional documentation and infrastructure reasoning.
