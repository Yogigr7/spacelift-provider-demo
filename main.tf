module "tagging" {
source           = "./modules/tagging"

  business_contact = "andrew.hill@rate.com"
  business_owner   = "andrew hill"
  tech_contact     = "cpe@rate.com"
  tech_owner       = "cpe-team"
  code_repo        = "https://github.com/Guaranteed-Rate/spacelift-demo"
  compliance       = "none"
  criticality      = "high"
  environment      = "nonprod"
  product          = "cloud networking and guardrails"
  public_facing    = "no"
  retirement_date  = "2036-12-31"
}

resource "random_integer" "test_bucket" {
  min = 1000
  max = 9999
}
#test
resource "aws_s3_bucket" "test_bucket" {
  bucket = "test-bucket-yogi-spacelift-provider${random_integer.test_bucket.result}"
  tags = merge(module.tagging.value, {
    "PermissionsBoundary" = "JuniorCPE_PermissionsBoundary"
  })
}
#nonprod
resource "aws_s3_bucket" "nonprod_bucket" {
  provider = aws.nonprod
  bucket = "nonprod-bucket-yogi-spacelift-provider-nonprod${random_integer.test_bucket.result}"
  tags = merge(module.tagging.value, {
    "PermissionsBoundary" = "JuniorCPE_PermissionsBoundary"
  })
}
