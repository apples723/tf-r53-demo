#automatically grabs the latest ubuntu 18.04(bionic) ami 
data "aws_ami" "ubuntu" {
  most_recent = true
  owners = ["099720109477"]

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-bionic-18.04-amd64-server-*"]
  }
}
#creates the apache webserver web01
resource "aws_instance" "web01"{
  ami           = data.aws_ami.ubuntu.id
  instance_type = "t2.micro" #size of instance
  key_name        = "web01" #private key to use 
  vpc_security_group_ids = [data.terraform_remote_state.vpc.outputs.http_ssh_sg] #using the data resource "vpc"
  subnet_id = data.terraform_remote_state.vpc.outputs.public_subnet[0] #using the data resource "vpc"
  #installs apache on the instance right after completion is finished
  provisioner "remote-exec" {
    inline = [
      "sleep 15",
      "sudo apt-get update",
      "sudo apt-get -y install apache2",
    ]
    #tell terraform how to connect to the instance
    connection {
      type        = "ssh"
      user        = "ubuntu"
      private_key = file("web01.pem")
      host        = self.public_ip
    }
  }
}
#outputs the eip of the intance
output "eip" {
  value = aws_instance.web01.public_ip
}

