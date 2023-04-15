
resource "aws_instance" "web" {
    ami = "ami- 05f********"
    instance_type = "t3.micro"
    vpc_security_group_ids = [aws_security_group.allow_ssh_sg.id]

    tags = {
        Name = "Terraform-instance-Name"
    }
}

variable "sg" {}

output "private_dns" {
    value = aws_instance.web.private_dns
}