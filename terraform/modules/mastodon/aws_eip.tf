resource "aws_eip" "mastodon_nat_eip_public_a" {
  vpc   = true
}

resource "aws_eip" "mastodon_nat_eip_public_c" {
  vpc   = true
}