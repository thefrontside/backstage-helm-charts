#!/bin/sh

set_perms()
{
  chmod -R 0600 $1
  chown -R 999:999 $1
}

create_csr_key()
{
  filename=$1
  cn=$2

  # openssl genrsa -out "$filename.key" 2048
  openssl req -new -nodes -keyout "$filename.key" -out "$filename.csr" -subj "/CN=$cn"
  # openssl pkcs8 -topk8 -in "$filename.key" -out "$filename.pkcs8.key" -passin pass:pw -passout pass:pw
  set_perms "$filename.csr"
  set_perms "$filename.key"
  # set_perms "$filename.pkcs8.key"
}

create_root_cert()
{
  cn=$1

  create_csr_key root $cn
  openssl x509 -req -in root.csr -days $TTL -extfile /etc/ssl/openssl.cnf -extensions v3_ca -signkey root.key -out root.crt
  set_perms root.crt
}

create_cert()
{
  filename=$1
  cn=$2

  create_csr_key $filename $cn
  openssl x509 -req -in "$filename.csr" -days $TTL -CA root.crt -CAkey root.key -CAcreateserial -out "$filename.crt"
  set_perms "$filename.crt"
}

TTL=45

apk upgrade --update-cache --available && apk add openssl

cd /certgen/certs

create_root_cert {{ .Values.serverName }}-ca
create_cert server {{ .Values.serverName }}
create_cert client {{ .Values.clientName }}
