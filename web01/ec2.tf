data "aws_ami" "ubuntu" {
  most_recent = true
  owners = ["099720109477"]

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-bionic-18.04-amd64-server-*"]
  }
}

resource "aws_instance" "web01"{
  ami           = data.aws_ami.ubuntu.id
  instance_type = "t2.micro"
  key_name        = "web01"
  security_groups = [data.terraform_remote_state.vpc.outputs.http_ssh_sg]
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
      private_key = file("web01.pem")
      host        = self.public_ip
    }
  }

}