
resource "aws_security_group" "instance" {
  name        = "webgroup"
  description = "Allow  http"
  ingress {
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["194.80.232.71/32"]
  }
}


resource "aws_instance" "test_1" {
  ami                    = "ami-0a244485e2e4ffd03"
  instance_type          = "t2.micro"

  user_data              = <<-EOF
              #!/bin/bash
              echo "Hello, World" > index.html
              nohup busybox httpd -f -p 8080 &
              EOF

}

resource "aws_s3_bucket" "b1" {
  bucket = "s3-terraform-123123"

  tags = {
    Name = "My bucket"
    Environment = "Dev"
  }
}

resource "aws_s3_bucket_acl" "bucket_acl" {
  bucket = aws_s3_bucket.b1.id
  acl    = "private"
}

resource "aws_s3_bucket_object" "object" {
  bucket = aws_s3_bucket.b1.id
  key    = "profile"
  acl    = "private"  
  source = "C:Users\\Eamon\\Downloads\\game.html"
  
}