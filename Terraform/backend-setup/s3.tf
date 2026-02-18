resource "aws_s3_bucket" "wander_bucket" {
  bucket = "wanderlust-state-bucket"

  tags = {
    Name        = "wanderlust-state-bucket"
  }
}