
resource "aws_instance" "instance_public1" {
    ami                    = var.amazon_machine_image
    instance_type          = var.instance_type
    subnet_id              = module.networking.public_subnet[0].id
    vpc_security_group_ids = [module.networking.front_alb]
    tags                   = {
    Name                   = "instance_public1"
   
  }
  provisioner "local-exec" {
    command = "public ip1  ${self.public_ip} >> allips.txt"
  }

  provisioner "remote-exec" {
      connection {
        type = "ssh"
        user = "ec2-user"
        private_key = "${file("/home/david/Desktop/iti.pem")}"
        host = aws_instance.instance_public1.public_ip
    }
    inline = [
        "yum update -y" ,
        "yum install -y httpd",
        "systemctl start httpd",
        "systemctl enable httpd",
        "echo '<h1>Hello World from $(hostname -f)</h1>' > /var/www/html/index.html"
    ]
}
 
}
resource "aws_instance" "instance_public2" {
    ami                    = var.amazon_machine_image
    instance_type          = var.instance_type
    subnet_id              = aws_subnet.public_subnet[1].id
    vpc_security_group_ids = [aws_security_group.front_alb.id]
    tags                   = {
    Name                   = "instance_public2"
   
  }
  provisioner "local-exec" {
    command = "public ip2  ${self.public_ip} >> allips.txt"
  }

  provisioner "remote-exec" {
    connection {
        type = "ssh"
        user = "ec2-user"
        private_key = "${file("/home/david/Desktop/iti.pem")}"
        host = aws_instance.instance_public2.public_ip
    }
    inline = [
        "yum update -y" ,
        "yum install -y httpd",
        "systemctl start httpd",
        "systemctl enable httpd",
        "echo '<h1>Hello World from $(hostname -f)</h1>' > /var/www/html/index.html"
    ]
}

 }


resource "aws_instance" "instance_private1" {
    ami                    = var.amazon_machine_image
    instance_type          = var.instance_type
    subnet_id              = aws_subnet.private_subnet[0].id
    vpc_security_group_ids = [aws_security_group.back_alb.id]
    tags                   = {
    Name                   = "instance_private1"
   
  }
    provisioner "local-exec" {
    command = "private ip1  ${self.private_ip} >> allips.txt"
  }

  provisioner "remote-exec" {
    connection {
        type = "ssh"
        user = "ec2-user"
        private_key = "${file("/home/david/Desktop/iti.pem")}"
        host = aws_instance.instance_private1.private_ip
    }
    inline = [
        "yum update -y" ,
        "yum install -y httpd",
        "systemctl start httpd",
        "systemctl enable httpd",
        "echo '<h1>Hello from private(1) $(hostname -f)</h1>' > /var/www/html/index.html"
    ]
}
}


resource "aws_instance" "instance_private2" {
    ami                    = var.amazon_machine_image
    instance_type          = var.instance_type
    subnet_id              = aws_subnet.private_subnet[1].id
    vpc_security_group_ids = [aws_security_group.back_alb.id]
    tags                   = {
    Name                   = "instance_private2"
   
  }
    provisioner "local-exec" {
    command = "private ip2  ${self.private_ip} >> allips.txt"
  }

  provisioner "remote-exec" {
    connection {
        type = "ssh"
        user = "ec2-user"
        private_key = "${file("/home/david/Desktop/iti.pem")}"
        host = aws_instance.instance_private2.private_ip
    }
    inline = [
        "yum update -y" ,
        "yum install -y httpd",
        "systemctl start httpd",
        "systemctl enable httpd",
        "echo '<h1>Hello from private(2) $(hostname -f)</h1>' > /var/www/html/index.html"
    ]
}

 }