#keypair login

resource "aws_key_pair" "main" {
    key_name = "terra-key"

    public_key = file("terra-key.pub")
}
#vpc sg
resource "aws_default_vpc" "def"  {
    
   
}

resource "aws_security_group" "abc" {
    name = "automate-sg"
    description = "allow ssh and web traffic"
    vpc_id = aws_default_vpc.def.id #interpolation syntax
    
    #inbound rule 
    ingress {
         from_port = 22
         to_port =22
         protocol = "tcp"
         cidr_blocks = ["0.0.0.0/0"]


    }
    ingress {
         from_port = 80
         to_port =80
         protocol = "tcp"
         cidr_blocks = ["0.0.0.0/0"]
    }


        

    
     #outbound rule
    egress {
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = ["0.0.0.0/0"]
        description = "allow all outbound traffic"
    }
    tags = {
        Name = "automate-sg"

    }
}
#ec2  
resource "aws_instance" "myec2"{
      for_each =tomap({
        abc1 = "t2.micro"
        xyz1 =  "t3.medium"
      }) 
       #metaargument for creating multiple instances
      depends_on = [ aws_security_group.abc , aws_key_pair.main] 
      key_name=aws_key_pair.main.key_name
      security_groups = [aws_security_group.abc.name]
      instance_type = each.value
      ami = var.ec2_ami #ubuntu machine
      user_data = file("install_nginx.sh")
    root_block_device {
      volume_size = var.env == "prd" ? 20 : var.ec2_default_root_volume_size
      volume_type = "gp3"
    }

    tags = {
    Name = each.key
    }
}

resource "aws_instance" "new_instance" {

    ami = "unknown"
    instance_type = "unknown"


}