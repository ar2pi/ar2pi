# Kubernetes

## Kubectl snippets

### Output resource manifest yaml

```sh
kubectl [COMMAND] --dry-run=client -o yaml > resource.yaml
```

### Cheat sheet

[Official docs cheat sheet](https://kubernetes.io/docs/reference/kubectl/cheatsheet/)

```sh
# create nginx pod on port 8080, with label tier=db and associated ClusterIP service 
kubectl run nginx --image=nginx:latest --port 8080 -l tier=db --expose true
# create nginx deployment, with 3 replicas in dev namespace
kubectl create deploy webapp --image nginx -r 3 -n dev
# print imperative create command options to create LoadBalancer
kubectl create svc loadbalancer -h

# generate deployment yaml file (-o yaml). Don't create it(--dry-run) with 4 replicas (--replicas=4)
kubectl create deployment --image=nginx nginx --replicas=4 --dry-run=client -o yaml > nginx-deployment.yaml

# scale a replicaset named 'foo' to 3
kubectl scale --replicas=3 rs/foo
# update existing resource
kubectl edit pod/nginx
# terminate existing resource and recreate it (useful when edit not possible )
kubectl replace --force -f nginx-deployment.yaml

# stream all pods logs with label name=myLabel (stdout)
kubectl logs -f -l env=dev --all-containers

# count pods in env dev and app foo
kubectl get pods -l env=dev,app=foo --no-headers | wc -l

# taint node
kubectl taint nodes node01 spray=mortein:NoSchedule
# remove taint from node
kubectl taint nodes node01 spray=mortein:NoSchedule-

# label node
kubectl label node/node01 color=blue
```

### Describe API resources

```sh
# list all possible resources
kubectl api-resources

NAME                              SHORTNAMES   APIVERSION                             NAMESPACED   KIND
bindings                                       v1                                     true         Binding
componentstatuses                 cs           v1                                     false        ComponentStatus
configmaps                        cm           v1                                     true         ConfigMap
endpoints                         ep           v1                                     true         Endpoints
events                            ev           v1                                     true         Event
limitranges                       limits       v1                                     true         LimitRange
namespaces                        ns           v1                                     false        Namespace
nodes                             no           v1                                     false        Node
persistentvolumeclaims            pvc          v1                                     true         PersistentVolumeClaim
persistentvolumes                 pv           v1                                     false        PersistentVolume
pods                              po           v1                                     true         Pod
podtemplates                                   v1                                     true         PodTemplate
replicationcontrollers            rc           v1                                     true         ReplicationController
resourcequotas                    quota        v1                                     true         ResourceQuota
secrets                                        v1                                     true         Secret
serviceaccounts                   sa           v1                                     true         ServiceAccount
services                          svc          v1                                     true         Service
mutatingwebhookconfigurations                  admissionregistration.k8s.io/v1        false        MutatingWebhookConfiguration
validatingwebhookconfigurations                admissionregistration.k8s.io/v1        false        ValidatingWebhookConfiguration
customresourcedefinitions         crd,crds     apiextensions.k8s.io/v1                false        CustomResourceDefinition
apiservices                                    apiregistration.k8s.io/v1              false        APIService
controllerrevisions                            apps/v1                                true         ControllerRevision
daemonsets                        ds           apps/v1                                true         DaemonSet
deployments                       deploy       apps/v1                                true         Deployment
replicasets                       rs           apps/v1                                true         ReplicaSet
statefulsets                      sts          apps/v1                                true         StatefulSet
tokenreviews                                   authentication.k8s.io/v1               false        TokenReview
localsubjectaccessreviews                      authorization.k8s.io/v1                true         LocalSubjectAccessReview
selfsubjectaccessreviews                       authorization.k8s.io/v1                false        SelfSubjectAccessReview
selfsubjectrulesreviews                        authorization.k8s.io/v1                false        SelfSubjectRulesReview
subjectaccessreviews                           authorization.k8s.io/v1                false        SubjectAccessReview
horizontalpodautoscalers          hpa          autoscaling/v2                         true         HorizontalPodAutoscaler
cronjobs                          cj           batch/v1                               true         CronJob
jobs                                           batch/v1                               true         Job
certificatesigningrequests        csr          certificates.k8s.io/v1                 false        CertificateSigningRequest
leases                                         coordination.k8s.io/v1                 true         Lease
endpointslices                                 discovery.k8s.io/v1                    true         EndpointSlice
events                            ev           events.k8s.io/v1                       true         Event
flowschemas                                    flowcontrol.apiserver.k8s.io/v1beta2   false        FlowSchema
prioritylevelconfigurations                    flowcontrol.apiserver.k8s.io/v1beta2   false        PriorityLevelConfiguration
helmchartconfigs                               helm.cattle.io/v1                      true         HelmChartConfig
helmcharts                                     helm.cattle.io/v1                      true         HelmChart
addons                                         k3s.cattle.io/v1                       true         Addon
nodes                                          metrics.k8s.io/v1beta1                 false        NodeMetrics
pods                                           metrics.k8s.io/v1beta1                 true         PodMetrics
ingressclasses                                 networking.k8s.io/v1                   false        IngressClass
ingresses                         ing          networking.k8s.io/v1                   true         Ingress
networkpolicies                   netpol       networking.k8s.io/v1                   true         NetworkPolicy
runtimeclasses                                 node.k8s.io/v1                         false        RuntimeClass
poddisruptionbudgets              pdb          policy/v1                              true         PodDisruptionBudget
podsecuritypolicies               psp          policy/v1beta1                         false        PodSecurityPolicy
clusterrolebindings                            rbac.authorization.k8s.io/v1           false        ClusterRoleBinding
clusterroles                                   rbac.authorization.k8s.io/v1           false        ClusterRole
rolebindings                                   rbac.authorization.k8s.io/v1           true         RoleBinding
roles                                          rbac.authorization.k8s.io/v1           true         Role
priorityclasses                   pc           scheduling.k8s.io/v1                   false        PriorityClass
csidrivers                                     storage.k8s.io/v1                      false        CSIDriver
csinodes                                       storage.k8s.io/v1                      false        CSINode
csistoragecapacities                           storage.k8s.io/v1beta1                 true         CSIStorageCapacity
storageclasses                    sc           storage.k8s.io/v1                      false        StorageClass
volumeattachments                              storage.k8s.io/v1                      false        VolumeAttachment
ingressroutes                                  traefik.containo.us/v1alpha1           true         IngressRoute
ingressroutetcps                               traefik.containo.us/v1alpha1           true         IngressRouteTCP
ingressrouteudps                               traefik.containo.us/v1alpha1           true         IngressRouteUDP
middlewares                                    traefik.containo.us/v1alpha1           true         Middleware
middlewaretcps                                 traefik.containo.us/v1alpha1           true         MiddlewareTCP
serverstransports                              traefik.containo.us/v1alpha1           true         ServersTransport
tlsoptions                                     traefik.containo.us/v1alpha1           true         TLSOption
tlsstores                                      traefik.containo.us/v1alpha1           true         TLSStore
traefikservices                                traefik.containo.us/v1alpha1           true         TraefikService

# print fields documentation
kubectl explain svc.spec.ports
kubectl explain pods.spec.containers --recursive
```

## List cluster resources

```sh
# list all resources
kubectl get all -A
# list all kube-system resources
kubectl get all -n kube-system

# show Custom Resource Definitions (CRDs) installed by Istio
kubectl get crds -n istio-system

# watch all resources
watch kubectl get all -A
```

## Change default namespace

```sh
kubectl config set-context $(kubectl config current-context) --namespace dev
```

## Internal DNS

Within same namespace: `http://{service_name}`  

Between distinct namespaces: `http://{service_name}.{namespace}.svc.cluster.local`

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

[Zsh plugin](https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/kubectl)

## Install Kubernetes

#### On Linux (Debian)

Using community-owned package repositories (see [blog post](https://kubernetes.io/blog/2023/08/15/pkgs-k8s-io-introduction/#how-to-migrate-deb))
```sh
ver=$(curl -sSL https://dl.k8s.io/release/stable.txt | egrep -o "[0-9]+\.[0-9]+")
echo "deb [signed-by=/etc/apt/keyrings/kubernetes-apt-keyring.gpg] https://pkgs.k8s.io/core:/stable:/v$ver/deb/ /" | sudo tee /etc/apt/sources.list.d/kubernetes.list
curl -sSL https://pkgs.k8s.io/core:/stable:/v$ver/deb/Release.key | sudo gpg --dearmor -o /etc/apt/keyrings/kubernetes-apt-keyring.gpg
sudo apt-get update
```

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
