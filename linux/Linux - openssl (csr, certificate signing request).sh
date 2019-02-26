
domain_name="newDomain.com";

email_address="optionalAdminEmail@adminEmailDomain.com";

org_branch="Software Development";

organization="Company, Inc.";

city="Rochester";

state="New York";

country="US";

days_valid=365;

key_size=4096;

output_dir="$Home";

## --------------- MODIFY LINES ABOVE THIS COMMENT TO MATCH YOUR NEEDS --------------- ##

out_unique="${output_dir}/${domain_name}_csr_$(date +'%Y%m%d%H%M%S')";
mkdir -p "${out_unique}";
openssl req \
-new \
-sha256 \
-nodes \
-newkey rsa:${key_size} \
-days ${days_valid} \
-out "${out_unique}/${domain_name}_certificateSigningRequest_getSignedByCA.csr" \
-keyout "${out_unique}/${domain_name}_privateKey_keepAndUseAfterDCV.key" \
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
