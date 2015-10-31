# Generate private key 
openssl genrsa -out $1.key 2048

# Generate CSR 
openssl req -new -key $1.key -out $1.csr

# Generate Self Signed Key
openssl x509 -req -days 365 -in $1.csr -signkey $1.key -out $1.crt

# Copy the files to the correct locations
#cp ca.crt /etc/pki/tls/certs
#cp ca.key /etc/pki/tls/private/ca.key
#cp ca.csr /etc/pki/tls/private/ca.csr

~    
