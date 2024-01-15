provider "cloudflare" {
  email = var.cf_email
  api_key = var.cf_api
}

resource "cloudflare_record" "test" {
  zone_id = "your-cloudflare-zone-id"
  name    = "example.com"
  value   = var.ec2_ip
  type    = "A"
  ttl     = 1
}
