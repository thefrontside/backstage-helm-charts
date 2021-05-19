```shell
microk8s install &&
microk8s enable dns storage registry &&
docker save backstage > backstage.tar &&
multipass transfer backstage.tar microk8s-vm:backstage.tar &&
microk8s ctr image import backstage.tar &&
microk8s config > ~/.kube/config &&
helm install backstage-core charts/backstage-core
```
