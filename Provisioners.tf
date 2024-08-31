#resource "tls_private_key" "example" {
 # algorithm = "RSA"
 # rsa_bits  = 4096
#}

#resource "null_resource" "example" {
 # connection {
  #  type        = "ssh"
   # host        = aws_instance.app-server1.private_ip
    #user        = "ubuntu"
    #private_key = tls_private_key.example.private_key_pem
  #}

   #provisioner "remote-exec" {
  #  inline = [
   #   "sudo yum install -y git", # Install Git
    #  "git clone https://github.com/codersgyan/realtime-chat-app.git",
     #  "cd realtime-chat-app",
      #  "npm install",
      # "curl -fsSL https://deb.nodesource.com/setup_18.x | sudo -E bash -",
      # "sudo apt-get install -y nodejs",
      # "sudo systemctl start nodejs"
    #]
 #}
#}

#resource "null_resource" "example2" {
 # connection {
  #  type        = "ssh"
   # host        = aws_instance.app-server2.private_ip
    #user        = "ubuntu"
    #private_key = tls_private_key.example.private_key_pem
  #}

   #provisioner "remote-exec" {
   # inline = [
   #   "sudo yum install -y git", # Install Git
   #   "git clone https://github.com/codersgyan/realtime-chat-app.git",
   #    "cd realtime-chat-app",
   #     "curl -fsSL https://deb.nodesource.com/setup_18.x | sudo -E bash -",
    #   "sudo apt-get install -y nodejs",
    
    #   "npm install",
     #  "sudo systemctl start nodejs"
    #]
 #}
#}