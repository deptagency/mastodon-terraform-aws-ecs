resource "aws_route_table_association" "mastodon_public_a" {
  route_table_id = "${aws_route_table.mastodon_public.id}"
  subnet_id      = "${aws_subnet.mastodon_public_a.id}"
  depends_on = [
    aws_internet_gateway.mastodon
  ]
}

resource "aws_route_table_association" "mastodon_public_c" {
  route_table_id = "${aws_route_table.mastodon_public.id}"
  subnet_id      = "${aws_subnet.mastodon_public_c.id}"
  depends_on = [
    aws_internet_gateway.mastodon
  ]
}

resource "aws_route_table_association" "mastodon_private_a" {
  route_table_id = "${aws_route_table.mastodon_private_a.id}"
  subnet_id      = "${aws_subnet.mastodon_private_a.id}"
  depends_on = [
    aws_internet_gateway.mastodon
  ]
}

resource "aws_route_table_association" "mastodon_private_c" {
  route_table_id = "${aws_route_table.mastodon_private_c.id}"
  subnet_id      = "${aws_subnet.mastodon_private_c.id}"
  depends_on = [
    aws_internet_gateway.mastodon
  ]
}
