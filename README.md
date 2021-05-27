```shell
microk8s install &&
microk8s enable dns storage registry &&
docker save backstage > backstage.tar &&
multipass transfer backstage.tar microk8s-vm:backstage.tar &&
microk8s ctr image import backstage.tar &&
microk8s config > ~/.kube/config &&
helm install backstage-core charts/backstage-core
```

```shell
docker save cert-gen > cert-gen.tar &&
multipass transfer cert-gen.tar microk8s-vm:cert-gen.tar &&
microk8s ctr image import cert-gen.tar
```

```shell
psql "sslcert=/config/certs/client.crt sslkey=/config/certs/client.key sslrootcert=/config/certs/root.crt port=5432 dbname=backstage sslmode=require" -h backstage-postgres -U backstage
```
