variable "sg_name" {
    description = "Nombre del grupo de seguridad"
    type = string
}

variable "environment" {
    description = "Nombre del entorno"
    type = string
}

variable "allowed_cidr_blocks" {
    description = "value"
    type = list(string)
    default = [ "0.0.0.0/0" ]
}
variable "ami" {
    description = "Image"
    type = string    
}

variable "allow_ssh" {
    description = "Port"
    type = number
    default = 22
}
variable "allow_http" {
    description = "Port"
    type = number
    default = 8000
}

variable "key_a" {
    description = "LLave de accesso a SSH"
    type = string    
}

variable "instance_type" {
    description = "Tipo de instancia"
    type = string
}
variable "availability_zone" {
    description = "Zona de disponibilidad"
    type = string
}


