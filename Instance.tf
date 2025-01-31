resource "aws_instance" "web" {
  ami                    = var.amiID[var.region]
  instance_type          = "t3.micro"
  key_name               = "terraformkey"
  vpc_security_group_ids = [aws_security_group.dove-sg.id]
  availability_zone      = var.zone1
  tags = {
    Name    = "Dove-web"
    project = "Dove"
  }
  provisioner "file" {
    source      = "web.sh"
    destination = "/tmp/web.sh"

  }


  connection {
    type = "ssh"
    user = var.webuser
    private_key = file("terraformkey")
    host = self.public_ip
  
  }

  provisioner "remote-exec" {

    inline = [
      "chmod +x /tmp/web.sh",
      "sudo /tmp/web.sh"
    ]

  } 

}