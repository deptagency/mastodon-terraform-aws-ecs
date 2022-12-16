resource "aws_nat_gateway" "mastodon_nat_gateway_public_a" {
  subnet_id      = aws_subnet.mastodon_public_a.id
  allocation_id  = aws_eip.mastodon_nat_eip_public_a.id
  depends_on     = [aws_internet_gateway.mastodon]
}

resource "aws_nat_gateway" "mastodon_nat_gateway_public_c" {
  subnet_id      = aws_subnet.mastodon_public_a.id
  allocation_id  = aws_eip.mastodon_nat_eip_public_c.id
  depends_on     = [aws_internet_gateway.mastodon]
}