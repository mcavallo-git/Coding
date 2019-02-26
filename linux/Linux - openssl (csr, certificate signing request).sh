
domain_name="newDomain.com";

email_address="optionalAdminEmail@adminEmailDomain.com";

org_branch="Software Development";

organization="Company, Inc.";

city="Rochester";

state="New York";

country="US";

openssl req \
-new \
-sha256 \
-nodes \
-newkey rsa:4096 \
-out "./${domain_name}_certificateSigningRequest_getSignedByCA.csr" \
-keyout "./${domain_name}_privateKey_keepAndUseAfterDCV.key" \
-config <(
cat <<-EOF
[req]
default_bits = 4096
prompt = no
default_md = sha256
req_extensions = req_ext
distinguished_name = dn

[ dn ]
C=${country}
ST=${state}
L=${city}
O=${organization}
OU=${org_branch}
emailAddress=${email_address}
CN = *.${domain_name}

[ req_ext ]
subjectAltName = @alt_names

[ alt_names ]
DNS.1 = ${domain_name}
DNS.2 = *.${domain_name}
EOF
);
