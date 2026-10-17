variable "ami_id"{
    description = "ID de la imagen a utilizar para la instancia"
    default = "ami-xxxxxxxx"
}

variable "instance_type" {
    description = "tipo de instancia a utilizar"
    default = "t3.micro"
}