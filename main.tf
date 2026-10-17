provider aws {
    region = "us-east-1"
}

resource "aws_instance" "nginx-server"{
    ami = "ami-0c02fb56b23889567"
    instance_type = "t3.micro"
}