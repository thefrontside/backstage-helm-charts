```shell
microk8s install &&
microk8s enable dns storage registry &&
microk8s config > ~/.kube/config
```

```shell
docker save backstage > backstage.tar &&
multipass transfer backstage.tar microk8s-vm:backstage.tar &&
microk8s ctr image import backstage.tar
```

```shell
helm install backstage-core charts/backstage-core
```

```shell
docker save cert-gen > cert-gen.tar &&
multipass transfer cert-gen.tar microk8s-vm:cert-gen.tar &&
microk8s ctr image import cert-gen.tar
```

```shell
helm install certgen charts/certgen
```

```shell
psql -h backstage-postgres -U backstage "sslcert=/config/certs/client.crt sslkey=/config/certs/client.key sslrootcert=/config/certs/root.crt sslmode=verify-ca dbname=backstage"
```

```shell
kubectl debug backstage-7fb78f89dd-gs9tc -it --copy-to=my-debugger --container=backstage -- sh
```
