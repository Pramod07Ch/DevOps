variable "sample" {
    default  =  "Welcome to terraform learning"
}

output "sample_op" {
    value   =   var.sample
}

output "sample_op_2" {
    value   =   "value of the sample variable is ${var.sample}"
}

# variable can be accessed without ${}
# if given ina string then its required

variable "integer" {
    default = 1000
}

output "number" {
    value = var.integer 
}

# List variable 
variable "sample_list" {
    default = [
        "Terraform",
        "Training",
        "Pulumi",
        "Cloud Formation",
        120,
        true,
    ]
}

# From the above list block, data in that block can be of any type 
output "sample_list_op" {
    value = "Welcome to ${var.sample_list[0]} Training and duration of the training is  ${var.sample_list[4]} hours"
}

# map variable type

variable "sample_map" {
    default = {
        Mode = "Online" ,
        Training = "DevOps" ,
        Timings = "0730_AM_CET"
    }
}

output "sample_map_op" {
    value   =   "Welcome to ${var.sample_map["Mode"]} - ${var.sample_map["Training"]} Training and the batch timings are ${var.sample_map["Timings"]}"
}

# Declaring an empty variable
variable "city" {}

output "city_name" {
    value   =   var.city
}

output "city_name_op_1" {
    value   =   "Name of the given city ${var.city}"
}