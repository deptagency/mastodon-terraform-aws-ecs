resource "aws_route" "public" {
   route_table_id = aws_route_table.mastodon_public.id
   gateway_id = aws_internet_gateway.mastodon.id
   destination_cidr_block = "0.0.0.0/0"
}

resource "aws_route" "private_a" {
   route_table_id = aws_route_table.mastodon_private_a.id
   destination_cidr_block = "0.0.0.0/0"
   nat_gateway_id = aws_nat_gateway.mastodon_nat_gateway_public_a.id
}

resource "aws_route" "private_c" {
   route_table_id = aws_route_table.mastodon_private_c.id
   destination_cidr_block = "0.0.0.0/0"
   nat_gateway_id = aws_nat_gateway.mastodon_nat_gateway_public_c.id
}
resource "aws_route_table" "mastodon_public" {
  vpc_id = "${aws_vpc.mastodon.id}"
}

resource "aws_route_table" "mastodon_private_a" {
  vpc_id = "${aws_vpc.mastodon.id}"
}

resource "aws_route_table" "mastodon_private_c" {
  vpc_id = "${aws_vpc.mastodon.id}"
}
