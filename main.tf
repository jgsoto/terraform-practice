module "nginx_server_module" {
  source = "./nginx_server_module"

  ami_id = "ami-0c55b159cbfafe1f0"
  instance_type = "t2.micro"
}

output "server_ip" {
  description = "The public IP of the Nginx server"
  value = module.nginx_server_module.public_ip
}