resource "aws_instance" "inference" {
  #   Ubuntu Server 24.04 LTS (HVM), SSD Volume Type
  # ami-09040d770ffe2224f
  ami           = "ami-09040d770ffe2224f"
  instance_type = "t2.micro"

  vpc_security_group_ids = [aws_security_group.allow_ssh.id, aws_security_group.allow_http.id]

  user_data = <<-EOF
              #!/bin/bash
              yum update -y
              yum install -y docker
              systemctl start docker
              systemctl enable docker
              docker run -d -p 80:80 nginx
              EOF

  tags = {
    Name = "Inference"
  }
}