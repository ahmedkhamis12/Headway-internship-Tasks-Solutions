# Static Website Hosting on AWS S3

This project hosts a static website on an Amazon S3 bucket and enables public access. The website includes an HTML page and an image, and it’s configured to be accessible globally via S3’s static website hosting. Optionally, you can integrate it with AWS CloudFront for improved performance.

## Table of Contents
- [Overview](#overview)
- [Prerequisites](#prerequisites)
- [Setup](#setup)
- [Access the Website](#access-the-website)

## Overview
This project automates the steps required to:
1. Create an HTML file with custom content.
2. Configure an S3 bucket for static website hosting.
3. Upload HTML and image files to the bucket.
4. Set public access permissions for the bucket.

The script is designed to be executed in a Bash environment with AWS CLI configured.

## Prerequisites
- **AWS Account**: Ensure you have an AWS account and access to S3 services.
- **AWS CLI**: Install and configure the AWS CLI with necessary permissions:
  - `s3:PutObject`
  - `s3:PutBucketPolicy`
  - `s3:PutBucketWebsite`
  - `s3:GetObject`
- **Bash**: Run this script in a Bash environment, such as Linux, macOS, or Windows Subsystem for Linux (WSL).

## Setup

1. **Clone the Repository**:
   ```bash
   git clone https://github.com/ahmedkhamis12/Headway-internship-Tasks-Solutions.git
   cd your-repo-name
2. **Configure AWS CLI: Set up your AWS CLI by running**:
   ```bash
   aws configure
   
3. **Run the script**:
   ```bash
   ./deploy_website.sh

## Access the Website   

 **Once deployed, the static website will be accessible at**:
   ```bash
   http://headway-bucket-website.s3-website-us-east-1.amazonaws.com
