#Configuración para guardar el archivo tfstate#
terraform{
    backend "s3" {
        bucket = "terraform-practice"
        key    = "terraform.tfstate"
        region = "us-east-1"
    }
}

#si se necesitan varias instancias con la misma configuracion se puede crear un modulo y llamarlo varias veces#
module "nginx_server_module" {
  source = "./nginx_server_module"

  ami_id = "ami-0c55b159cbfafe1f0"
  instance_type = "t2.micro"
}

module "nginx_qa_module" {
  source = "./nginx_server_module"

  ami_id = "ami-0c55b159cbfafe1f0"
  instance_type = "t2.micro"
}

output "server_ip" {
  description = "The public IP of the Nginx server"
  value = module.nginx_server_module.public_ip
}

output "qa_server_ip" {
  description = "The public IP of the Nginx QA server"
  value = module.nginx_qa_module.public_ip
}