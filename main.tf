variable "ami_id"{
    description = "ID de la imagen a utilizar para la instancia"
    default = "ami-xxxxxxxx"
}

variable "instance_type" {
    description = "tipo de instancia a utilizar"
    default = "t3.micro"
}

#provider: proveedor de servicio (aws, azure, google, etc)#
provider "aws" {
  region = "us-east-1"
}

#resource: recurso a crear (instancia, bucket, etc)#
resource "aws_instance" "nginx-server" {
  #image: imagen a utilizar para la instancia#
  ami = var.ami_id
  #tipo de instancia#
  instance_type = var.instance_type

  #comando que se ejecuta al crear la instancia#
  user_data = <<-EOF
                #!/bin/bash
                sudo apt update -y
                sudo apt install nginx -y
                sudo systemctl enable nginx
                sudo systemctl start nginx
                EOF 

  #asignar clave SSH a la instancia#
  key_name               = aws_key_pair.nginx-server-ssh.key_name
  vpc_security_group_ids = aws_security_group.nginx-server-sg.id

  #etiquetas para identificar la instancia#
  tags = {
    Name        = "nginx-server"
    Environment = "practice"
    Owner       = "jgsoto"
    Team        = "UCE"
    Project     = "terraform-practice"
  }

}

#crear clave SSH para la instancia#
resource "aws_key_pair" "nginx-server-ssh" {
  key_name   = "nginx-server-ssh"
  public_key = file("nginx-server-key.pub")

  tags = {
    Name        = "nginx-server-ssh"
    Environment = "practice"
    Owner       = "jgsoto"
    Team        = "UCE"
    Project     = "terraform-practice"
  }
}

#security group: para abrir los puertos necesarios de la instancia#
resource "aws_scurity_group" "nginx-server-sg" {
  name        = "nginx-server-sg"
  description = "Security group for Nginx server"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name        = "nginx-server-sg"
    Environment = "practice"
    Owner       = "jgsoto"
    Team        = "UCE"
    Project     = "terraform-practice"
  }
}

#output: valores de salida que se generan al crear la instancia#
output "public_ip" {
  description = "The public IP of the Nginx server"
  value = aws_instance.nginx-server.public_ip
}
