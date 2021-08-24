# Kubernetes

## Install kubectl

[https://kubernetes.io/es/docs/tasks/tools/install-kubectl/](https://kubernetes.io/es/docs/tasks/tools/install-kubectl/)

---
#### On Mac
```sh
os_kernel=darwin
```
#### On Linux (Debian)
```sh
os_kernel=linux
```
---

```sh
# ...
version=1.20.9
arch=amd64
curl -LO https://storage.googleapis.com/kubernetes-release/release/v$version/bin/$os_kernel/$arch/kubectl
chmod +x ./kubectl
sudo mv ./kubectl /usr/local/bin/kubectl
```
