# obtener el VPC por defecto
data "aws_vpc" "default" {
    default = true
}

data "aws_subnet" "default" {
    vpc_id            = data.aws_vpc.default.id
    availability_zone = var.availability_zone 
    
    filter {
      name = "default-for-az"
      values = ["true"]
    }
}

# Security group para la instancia
resource "aws_security_group" "ejemplo_iac" {
    name        = var.sg_name
    description = "Security group para ejemplo IAC"
    vpc_id      = data.aws_vpc.default.id
    
    egress {
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = var.allowed_cidr_blocks
    }

    tags = {
        Name = var.sg_name
    }

}

#resource for adding ingress rules.
resource "aws_vpc_security_group_ingress_rule" "allow_ssh_ipv4" {
  security_group_id = aws_security_group.ejemplo_iac.id
  cidr_ipv4         =  "0.0.0.0/0"
  from_port         = var.allow_ssh
  ip_protocol       = "tcp"
  to_port           = var.allow_ssh   
}

resource "aws_vpc_security_group_ingress_rule" "allow_http_ipv4" {
  security_group_id = aws_security_group.ejemplo_iac.id
  cidr_ipv4         =  "0.0.0.0/0"
  from_port         = var.allow_http
  ip_protocol       = "tcp"
  to_port           = var.allow_http
}



# Instancia EC2
resource "aws_instance" "ejmeplo" {
    ami = var.ami
    instance_type = var.instance_type
    subnet_id = data.aws_subnet.default.id

    vpc_security_group_ids = [aws_security_group.ejemplo_iac.id]
    key_name = var.key_a

    #Configuracion IMSV2 requerido
    metadata_options {
      http_endpoint               = "enabled"
      http_tokens                 = "required" 
      http_put_response_hop_limit =  1
    }


    tags = {
        Name        = "${var.environment}-ejemplo-iac-instance"
        Environment = var.environment
        ManagedBy   = "terraform"    
    }   
}

# Outputs para mostrar informacion de la instancia

output "instance_id" {
    description = "ID de la instancia EC2"
    value       = aws_instance.ejmeplo.id
  
}

output "instance_public_ip" {
    description = "IP publica de la instancia"
    value       = aws_instance.ejmeplo.public_ip
  
}
output "instance_private_ip" {
    description = "IP privada de la instancia"
    value       = aws_instance.ejmeplo.private_ip
  
}

output "instance_public_dns" {
    description = "DNS publico de la instancia"
    value       = aws_instance.ejmeplo.public_dns
  
}

output "instance_state" {
    description = "Estado de la instancia"
    value       = aws_instance.ejmeplo.instance_state
  
}