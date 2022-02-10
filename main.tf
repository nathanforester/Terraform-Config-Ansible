provider "aws" {
  region = "eu-west-2"
  access_key = var.aws_access_key
  secret_key = var.aws_secret_key
}

resource "aws_vpc" "mainvpc" {
  cidr_block = "167.0.0.0/16"
  tags = {
    Name = "${var.name}tf.vpc"
  }
}

# Create an igw
resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.mainvpc.id
  tags = {
    Name = "${var.name}.igw"
  }
}

# Create public sub
resource "aws_subnet" "subpublic" {
  vpc_id     = aws_vpc.mainvpc.id
  cidr_block = "167.0.1.0/24"
  availability_zone = "eu-west-2a"
  map_public_ip_on_launch = true

  tags = {
    Name = "${var.name}.subpublic"
  }
}

# Creating security group for webapp
resource "aws_security_group" "sgapp" {
  name        = "app-sg"
  description = "Allow http and https traffic"
  vpc_id      = aws_vpc.mainvpc.id

    ingress {
   description = "httpx from VPC"
   from_port = 443
   to_port = 443
   protocol = "tcp"
   cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
   description = "httpx from VPC"
   from_port = 80
   to_port = 80
   protocol = "tcp"
   cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
   description = "httpx from VPC"
   from_port = 8080
   to_port = 8080
   protocol = "tcp"
   cidr_blocks = ["0.0.0.0/0"]
  }

   ingress {
    description = "ssh"
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    
  }

  egress {
  to_port = 0
  from_port = 0
  protocol = -1
  cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.name}sg.app"
  }
}

# Creating a route table
resource "aws_route_table" "routepublic" {
  vpc_id = aws_vpc.mainvpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw.id
  }
  tags = {
    Name = "${var.name}.route.public"
  }
}

# Route table associations
resource "aws_route_table_association" "routeapp" {
  subnet_id = aws_subnet.subpublic.id
  route_table_id = aws_route_table.routepublic.id
}

# pre-assign private IP addresses  

# creating two EC2s to communicate with each other via SSH
resource "aws_instance" "nginx" {
	ami = var.ami_app
	instance_type = "t2.micro"
	key_name = var.ssh_key
    subnet_id = aws_subnet.subpublic.id
    private_ip = "167.0.1.10"
    vpc_security_group_ids = [aws_security_group.sgapp.id]
    associate_public_ip_address = true

	tags = {	
		Name = "nginx"	
	}
}

resource "null_resource" "connect_nginx" {
  provisioner "remote-exec" {
    inline = [
      "sudo echo 'ubuntu ALL=(ALL:ALL) NOPASSWD:ALL' | sudo EDITOR='tee -a' visudo"
    ]
    connection {
      host        = aws_instance.nginx.public_ip
      type        = "ssh"
      user        = "ubuntu"
      private_key = file("./Estio-Training-NForester")
    }
    
  }
  depends_on = [aws_instance.nginx]
}

resource "aws_instance" "ansible" {
	ami = var.ami_app
	instance_type = "t2.micro"
	key_name = var.ssh_key
	subnet_id = aws_subnet.subpublic.id
    vpc_security_group_ids = [aws_security_group.sgapp.id]
    associate_public_ip_address = true
    user_data = "${file("./ansible-script.sh")}"

    

  depends_on = [aws_instance.nginx]

  tags = {	
		Name = "ansible"	
	}
}

resource "null_resource" "connect_ansible" {
  provisioner "remote-exec" {
    inline = [
      "sudo su -l ubuntu -c 'sudo ansible-playbook -i /home/ubuntu/inventory.yaml /home/ubuntu/playbook.yaml'"
    ]
    connection {
      host        = aws_instance.ansible.public_ip
      type        = "ssh"
      user        = "ubuntu"
      private_key = file("./Estio-Training-NForester")
    }
    
  }
  depends_on = [aws_instance.ansible]
}

