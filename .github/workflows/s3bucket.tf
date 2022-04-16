resource "aws_s3_bucket" "b1" {

  bucket = "raghavsharma22222"

  acl = "private" # or can be "public-read"

  tags = {

    Name = "My bucket"

    Environment = "Dev"

  }

}

# Upload an object
resource "aws_s3_bucket_object" "object1" {
  for_each = fileset("C:\\Users\\ROG\\Downloads\\upload", "*")
  bucket   = aws_s3_bucket.b1.id
  key      = each.value
  source   = "C:\\Users\\ROG\\Downloads\\upload\\${each.value}"
  etag     = filemd5("C:\\Users\\ROG\\Downloads\\upload\\${each.value}")
}
