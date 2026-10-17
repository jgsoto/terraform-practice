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