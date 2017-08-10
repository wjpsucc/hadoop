# Use aws to Practice hdpca test

# Step 1: Create an AWS Account 
# Step 2: Run the EC2 Launch Instance Wizard 
# Step 3: Find the AMI for the Practice Exam 
	# 3.1. Click the Community AMIs tab on the left‐hand menu. 
	# 3.2. Type “Hortonworks” in the search box and press Enter: 
	# 3.3. You are looking for an AMI with a name similar to “Hortonworks HDPCA_x.x PracticeExam_vx” Click the Select button next to it
# Step 4: Choose an Instance Type -- You need at least a c3.2xlarge or c3.4xlarge
# Step 5: Configure Instance Details 
# Step 6: Add Storage 
# Step 7: Tag Instance 
# Step 8: Configure Security Group 
	# 8.2. Notice an SSH rule is already defined. Click the Add Rule button and add a  Custom TCP Rule for port 5901 with Custom IP equal to 0.0.0.0/0
# Step 9: Review Instance Launch

# Step 10: Create a Private Key File
# Step 11: Launch the Instance 
# Step 12: Determine the Public DNS of the EC2 Instance 
# Step 13: Install a VNC Client 

# Step 14: Connect to the EC2 Instance 

# Step 15: Verify HDP is Running 
# Step 16: The Exam Tasks 
# Step 17: Stopping the Instance 
# Step 18: Terminating the Instance 

# refer: https://2xbbhjxc6wk3v21p62t8n4d4-wpengine.netdna-ssl.com/wp-content/uploads/2015/04/HDPCA-PracticeExamGuide.pdf