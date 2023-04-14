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