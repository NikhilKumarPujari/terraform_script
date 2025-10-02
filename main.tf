module "dev-infra" {
  source         = "./infra-app"
  env            = "dev"
  bucket_name    = "infra-app-bucket001"
  instance_count = 1
  instance_type  = "t3.micro"
  ec2_ami_id     = "ami-02d26659fd82cf299"
  hash_key       = "studentID"
}
