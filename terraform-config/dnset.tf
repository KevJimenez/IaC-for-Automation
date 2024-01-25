
provider "cloudflare" {
  email = var.cf_email
  api_key = var.cf_api
}

resource "cloudflare_record" "a_record_cf" {
  zone_id = var.zonecf_id
  name    = "17110711.xyz"
  value   = aws_instance.app_server.public_ip
  type    = "A"
  ttl     = 1
}
