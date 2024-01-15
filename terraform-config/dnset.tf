provider "cloudflare" {
  email = var.cf_email
  api_key = var.cf_api
}

resource "cloudflare_record" "test" {
  zone_id = var.zonecf_id
  name    = "17110711.xyz"
  value   = var.ec2_ip
  type    = "A"
  ttl     = 1
}
