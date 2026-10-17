#provider: proveedor de servicio (aws, azure, google, etc)#
provider "aws" {
  region = "us-east-1"
}

#resource: recurso a crear (instancia, bucket, etc)#
resource "aws_instance" "nginx-server" {
  #image: imagen a utilizar para la instancia#
  ami           = "ami-0c02fb56b23889567"
  #tipo de instancia#
  instance_type = "t3.micro"

  #comando que se ejecuta al crear la instancia#
  user_data = <<-EOF
                #!/bin/bash
                sudo apt update -y
                sudo apt install nginx -y
                sudo systemctl enable nginx
                sudo systemctl start nginx
                EOF 
}