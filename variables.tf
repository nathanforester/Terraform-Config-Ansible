
variable "vpc_id" {
  type = string
  default= "vpc-08039043ffb902e94"
}

variable "aws_access_key" {
   type = string
}

variable "aws_secret_key" {
   type = string
}

variable "name" {
 type = string
 default= "Nathan.F"
}

variable  "ami_app" {
 type = string
 default = "ami-00b48f09c568b0014"
}

variable  "ssh_key" {
 type = string
 default = "Estio-Training-NForester"
}