provider "dnsimple" {
  token = "blabla"
  account = "blabla"
}

resource "dnsimple_record" "abcd" {
  domain = "blabla"
  type = "A"
  name = "blabla"
  value = "${aws_instance.web.0.public_ip}"
}
