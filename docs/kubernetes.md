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

echo '''
# kubectl auto completion
source <(kubectl completion zsh)
''' >> ~/.zshrc
```

## Install Kubernetes

#### On Linux (Debian)

kubeadm-config.yaml
```yaml
apiVersion: kubeadm.k8s.io/v1beta2
kind: ClusterConfiguration
kubernetesVersion: 1.21.1
controlPlaneEndpoint: "k8scp:6443"
networking:
  podSubnet: 192.168.0.0/16 # corresponds to calico.yaml CALICO_IPV4POOL_CIDR ip
  # cat calico.yaml | grep -C 10 CALICO_IPV4POOL_CIDR
```

```sh
ip addr show
# add eth ip to /etc/hosts

apt-get install -y kubeadm=1.21.1-00 kubelet=1.21.1-00 kubectl=1.21.1-00
apt-mark hold kubelet kubeadm kubectl

firewall-cmd --permanent --zone=public --add-port=6443/tcp --add-port=10250/tcp
# firewall-cmd --permanent --service=service --remove-port=6443/tcp --remove-port=10250/tcp

su - 
swapoff -a

sudo kubeadm init --config=kubeadm-config.yaml --upload-certs | tee kubeadm-init.out

mkdir -p $HOME/.kube
sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
sudo chown $(id -u):$(id -g) $HOME/.kube/config

wget https://docs.projectcalico.org/manifests/calico.yaml
kubectl apply -f calico.yaml

kubectl describe nodes <Tab> | less
kubectl get pod --all-namespaces
sudo kubeadm config print init-defaults

# allow control plane to run non-infrastructure pods
kubectl describe node | grep -i taint
kubectl taint nodes --all node-role.kubernetes.io/master-
```

## Snippets

### Output resource yaml

```sh
kubectl [COMMAND] --dry-run=client -o yaml > resource.yaml
```
