provider "aws" {
  region = var.aws_region
}

resource "aws_instance" "ubuntu" {
  count = 2
  ami           = var.ubuntu_ami_id
  instance_type = var.instance_type
  key_name      = var.key_name 
  vpc_security_group_ids = [aws_security_group.allow_all.id]
  availability_zone = element(data.aws_availability_zones.available.names, count.index)

  tags = {
    Name =  "Ubuntu-Server-${count.index + 1}"
  }

  user_data = <<-EOF
              #!/bin/bash
              # Rename ubuntu user to alvaro
              sudo usermod -l alvaro ubuntu
              sudo groupmod -n alvaro ubuntu
              sudo mv /home/ubuntu /home/alvaro
              sudo sed -i 's/ubuntu/alvaro/g' /etc/passwd /etc/shadow /etc/group /etc/sudoers /etc/cloud/cloud.cfg
              echo 'alvaro ALL=(ALL) NOPASSWD:ALL' | sudo tee /etc/sudoers.d/alvaro
              EOF
}

resource "aws_eip" "ubuntu_eip" {
  count     = 2
  instance  = aws_instance.ubuntu[count.index].id
}


data "aws_availability_zones" "available" {}

# resource "aws_ebs_volume" "ubuntu_storage" {
#   count             = 2
#   availability_zone = element(data.aws_availability_zones.available.names, count.index)
#   size              = var.block_storage_size
# }


# resource "aws_volume_attachment" "ubuntu_attach" {
#   count       = 2
#   device_name = "/dev/sdh"
#   volume_id   = aws_ebs_volume.ubuntu_storage[count.index].id  
#   instance_id = aws_instance.ubuntu[count.index].id  
# }



resource "aws_security_group" "allow_all" {
  name        = "allow_all"
  description = "Allow all inbound traffic"

  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks  = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks  = ["0.0.0.0/0"]
  }
}


