variable "region" {
  default = "us-west-2"
}
variable "tags" {
  default = {
    Product     = "inf"
    budget-area = "inf"
    group       = "inf"
    env         = "sandbox"
    Source      = "https://github.com/2uinc/tf-infrastructure"
  }
}
