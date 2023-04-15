# start with giving provider information

provider "aws" {
    region  =   "us-east-1"
}
resource "aws_instance" "web" {
    ami = "ami- 05f********"
    instance_type = "t3.micro"

    tags = {
        Name = "Terraform-instance"
    }
}

# Block to print the attribute 
output "private_dns_of_server" {
    value       = aws_instance.web.private_dns
}
