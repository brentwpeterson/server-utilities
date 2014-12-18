echo "Enter certificate name followed by [ENTER]:"
read cert
openssl req -new -newkey rsa:2048 -nodes -keyout $HOME/$cert.key -out $HOME/$cert.csr
