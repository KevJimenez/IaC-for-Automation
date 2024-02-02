#Secret Keys

cf_api = {{ lookup('env', 'CF_API') }}
cf_email = {{ lookup('env', 'CF_EMAIL') }}
zonecf_id = {{ lookup('env', 'ZONECF_ID') }}
pub_key = {{ lookup('env', 'PUB_KEY') }}