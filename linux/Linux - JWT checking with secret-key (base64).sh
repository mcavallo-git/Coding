#!/bin/bash


# Compute SHA-1 Hash of request_body using a secret key as an HMAC digest
# --> Github sent http_x_hub_signature ==> sha1=344b128bdb8a8cd0ace6c8ebde53e68410c1f08b

# See: https://stackoverflow.com/questions/7285059/hmac-sha1-in-bash

SECRET_KEY="soLength_muchSecret";

# echo -n "${SECRET_KEY}" | base64 | tr '+\/' '-_' | tr -d '=';
# echo -n "value" | openssl dgst -sha1 -hmac "key"


SECRET_KEY="soLength_muchSecret"

JSON_PAYLOAD='{"jwt_key":"jwt_val","hey_wait":"seeing this message is step 1 of 2, make sure to also calculate the digest of the JWT based off of its secret key/hash!","iat": 9876543210,"paste_url_into_browser":"https://en.wikipedia.org/wiki/Doge_(meme)"}'

echo -n "${JSON_PAYLOAD}" | openssl dgst -sha1 -hmac "${SECRET_KEY}";
# expected_outcome (not timestamped):
JWT_OUTPUT="eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJqd3Rfa2V5Ijoiand0X3ZhbCIsImhleV93YWl0Ijoic2VlaW5nIHRoaXMgbWVzc2FnZSBpcyBzdGVwIDEgb2YgMiwgbWFrZSBzdXJlIHRvIGFsc28gY2FsY3VsYXRlIHRoZSBkaWdlc3Qgb2YgdGhlIEpXVCBiYXNlZCBvZmYgb2YgaXRzIHNlY3JldCBrZXkvaGFzaCEiLCJpYXQiOjk4NzY1NDMyMTAsInBhc3RlX3VybF9pbnRvX2Jyb3dzZXIiOiJodHRwczovL2VuLndpa2lwZWRpYS5vcmcvd2lraS9Eb2dlXyhtZW1lKSJ9.BQp3cYNL1yUlEpS5hcSTZIasNscFJ9CO7v7dfDMXedM";


# output:
# echo -n "${json_body}" | openssl sha1;

# openssl enc -aes256 -base64 -in some.secret -out some.secret.enc && cat some.secret.enc
# openssl enc -aes256 -base64 -in some.secret -out some.secret.enc && cat some.secret.enc


### using digests:
# -md messagedigest
### aka
# -md sha1

