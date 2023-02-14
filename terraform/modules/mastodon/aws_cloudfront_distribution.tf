moved {
  from = aws_cloudfront_distribution.mastodon
  to = data.aws_cloudfront_distribution.mastodon
}

moved {
  from = aws_cloudfront_distribution.mastodon_file
  to = data.aws_cloudfront_distribution.mastodon_file
}
data "aws_cloudfront_distribution" "mastodon" {
  id = "E2AHSN1YTN3SWU"
}

data "aws_cloudfront_distribution" "mastodon_file" {
  id = "EMWZTA4UDMLUK"
}
