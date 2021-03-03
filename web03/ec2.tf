data "aws_ami" "ubuntu" {
  most_recent = true
  owners = ["099720109477"]

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-bionic-18.04-amd64-server-*"]
  }
}

resource "aws_instance" "web03"{
  ami           = data.aws_ami.ubuntu.id
  instance_type = "t2.micro"
  key_name        = "web01"
  vpc_security_group_ids = [data.terraform_remote_state.vpc.outputs.http_ssh_sg]
  subnet_id = data.terraform_remote_state.vpc.outputs.public_subnet[0]
  provisioner "remote-exec" {
    inline = [
      "sleep 15",
      "sudo apt-get update",
      "sudo apt-get -y install apache2",
    ]
    connection {
      type        = "ssh"
      user        = "ubuntu"
      private_key = file("web02.pem")
      host        = self.public_ip
    }
  }
}
output "eip" {
  value = aws_instance.web03.public_ip
}

