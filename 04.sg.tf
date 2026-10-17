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