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
    default     =   1000
}

output "number" {
    value   =   var.number
}

# list
variable "sample_list" {
    default     =   [
                "Terraform",
                "Training",
                99,
                true,
                "Cloud formation"
    ]
}

# from the above list bock, data in that block can be of any type
output sample_list_op" {
    value   =   "Welcome to ${var.sample_list[0]} ${var.sample_list[1]}  and duration is ${var.sample_list[2]} hours"
}
