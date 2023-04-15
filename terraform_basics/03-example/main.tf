# declaring module with name ec2

module "ec2" {
    source = "./ec2"
    sg  = module.sg.sg
}

# declaring module with name sg

module "sg" {
    source = "./sg"
}