Secure and Scalable AWS Infrastructure for Node.js Chat App
Overview
This project showcases a secure and scalable AWS infrastructure for a Node.js chat app using Terraform. The infrastructure includes:
VPC with public and private subnets
Internet Gateway and NAT Gateway for routing traffic
Security groups and NACLs for network security
Load balancer for distributing traffic
EC2 instances for running Node.js app
Monitoring and logging using VPC flow logs, CloudWatch, and CloudTrail
How it Works
VPC and Subnets: The VPC is created with two public subnets and two private subnets. The public subnets are used for the load balancer and bastion host, while the private subnets are used for the EC2 instances running the Node.js app.
Internet Gateway and NAT Gateway: The Internet Gateway is attached to the VPC and allows traffic to flow between the VPC and the internet. The NAT Gateway is used to allow outbound internet access from the private subnets.
Security Groups and NACLs: Security groups are used to control inbound and outbound traffic to the EC2 instances, while NACLs are used to control traffic at the subnet level.
Load Balancer: The load balancer is used to distribute traffic to the EC2 instances running the Node.js app.
EC2 Instances: The EC2 instances are created in the private subnets and run the Node.js chat app.
Monitoring and Logging: VPC flow logs are used to monitor traffic flowing through the VPC, while CloudWatch is used to monitor the EC2 instances and load balancer. CloudTrail is used to log API calls made to the AWS account.

Here's an expanded version of the README.md with a more detailed overview of how the project works:
Secure and Scalable AWS Infrastructure for Node.js Chat App
Overview
This project showcases a secure and scalable AWS infrastructure for a Node.js chat app using Terraform. The infrastructure includes:
VPC with public and private subnets
Internet Gateway and NAT Gateway for routing traffic
Security groups and NACLs for network security
Load balancer for distributing traffic
EC2 instances for running Node.js app
Monitoring and logging using VPC flow logs, CloudWatch, and CloudTrail
How it Works
VPC and Subnets: The VPC is created with two public subnets and two private subnets. The public subnets are used for the load balancer and bastion host, while the private subnets are used for the EC2 instances running the Node.js app.
Internet Gateway and NAT Gateway: The Internet Gateway is attached to the VPC and allows traffic to flow between the VPC and the internet. The NAT Gateway is used to allow outbound internet access from the private subnets.
Security Groups and NACLs: Security groups are used to control inbound and outbound traffic to the EC2 instances, while NACLs are used to control traffic at the subnet level.
Load Balancer: The load balancer is used to distribute traffic to the EC2 instances running the Node.js app.
EC2 Instances: The EC2 instances are created in the private subnets and run the Node.js chat app.
Monitoring and Logging: VPC flow logs are used to monitor traffic flowing through the VPC, while CloudWatch is used to monitor the EC2 instances and load balancer. CloudTrail is used to log API calls made to the AWS account.
Usage
Clone the repository
Run terraform init to initialize Terraform
Run terraform apply to deploy the infrastructure
Update the Node.js app code and deploy to EC2 instances
Test the chat app
Contributing
Contributions are welcome! Please submit a pull request with your changes.
License
This project is licensed under the MIT License.
