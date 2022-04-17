provider "aws" {
  profile = "default"
  shared_credentials_file = "credential"
  region  = "us-east-1"#
}

locals {
  current_directory = "echo $(pwd)"
}

resource "aws_s3_bucket" "tf_course" {

  bucket = "testingproject1010"
  acl    = "private"
}


#module "gitclone" {
 # source = "github.com/ajiteshsharma90/pipedream.git"
#}


resource "null_resource" "git_clone" {
  provisioner "local-exec" {
    command     = "get_repo.sh"
    interpreter = ["bash"]
  }
}
