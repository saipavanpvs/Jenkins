#!/bin/bash

# Variables
AMI_ID="ami-0f75a13ad2e340a58"           # AMI ID
INSTANCE_TYPE="t2.micro"                 # Instance Type (You can modify it)
SECURITY_GROUP_ID="sg-00b3243907320dafb" # Security Group ID
SUBNET_ID="subnet-0faaa8a76ab3f06e3"     # Subnet ID
KEY_NAME="MyKeyvalue"                    # Key Pair Name
INSTANCE_NAME="Newserver_2"          # Instance Name

# Create EC2 Instance
echo "Launching EC2 instance..."

INSTANCE_ID=$(aws ec2 run-instances \
  --image-id $AMI_ID \
  --count 1 \
  --instance-type $INSTANCE_TYPE \
  --key-name $KEY_NAME \
  --security-group-ids $SECURITY_GROUP_ID \
  --subnet-id $SUBNET_ID \
  --tag-specifications "ResourceType=instance,Tags=[{Key=Name,Value=$INSTANCE_NAME}]" \
  --query "Instances[0].InstanceId" \
  --output text)

echo "EC2 instance created with ID: $INSTANCE_ID"

# Wait for the instance to be in the 'running' state
echo "Waiting for the instance to be in running state..."
aws ec2 wait instance-running --instance-ids $INSTANCE_ID

echo "Instance is now running!"

# Fetch the Public IP of the EC2 instance
PUBLIC_IP=$(aws ec2 describe-instances \
  --instance-ids $INSTANCE_ID \
  --query "Reservations[0].Instances[0].PublicIpAddress" \
  --output text)

echo "EC2 Instance Public IP: $PUBLIC_IP"

# Output instance details
echo "Instance $INSTANCE_NAME launched successfully!"
echo "Instance ID: $INSTANCE_ID"
echo "Public IP Address: $PUBLIC_IP"
