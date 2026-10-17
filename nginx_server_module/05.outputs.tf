#output: valores de salida que se generan al crear la instancia#
output "public_ip" {
  description = "The public IP of the Nginx server"
  value = aws_instance.nginx-server.public_ip
}
