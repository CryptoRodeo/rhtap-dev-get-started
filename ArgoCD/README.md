# ArgoCD

Bootstrap a basic ArgoCD application for local testing.

Make sure you have [Minikube](https://minikube.sigs.k8s.io/docs/start/?arch=%2Flinux%2Fx86-64%2Fstable%2Fbinary+download) installed.

## Setup
### Minikube


1. Create the following namespaces:

```bash
# For ArgoCD
kubectl create namespace argocd

# For ArgoCD Applications
kubectl create namespace demo-apps
```

2. Apply ArgoCD Manifests:

```bash
kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml
```

3. Get the initial admin password:
```
kubectl -n argocd get secret argocd-initial-admin-secret -o jsonpath="{.data.password}" | base64 -d
```

4. Access the ArgoCD API Server using a NodePort service:
```
kubectl apply -f service.yml
```

5. Get the service URL
```bash
# For Minikube
# Get the service URL
 minikube service argocd-server-nodeport -n argocd
```

6. Install the ArgoCD CLI:

```bash
curl -sSL -o argocd-linux-amd64 https://github.com/argoproj/argo-cd/releases/latest/download/argocd-linux-amd64
sudo install -m 555 argocd-linux-amd64 /usr/local/bin/argocd
rm argocd-linux-amd64
```

7. Access `<ip>:30080` with username: admin, password: `<see step 3>`:
```bash
argocd login <service-ip>:30080 --username admin --password <password> --insecure
```

8. Add your cluster to ArgoCD:
```bash
argocd cluster add <cluster-name, minikube for example>
# If it's the first cluster listed in your config:
argocd cluster add "$(kubectl config view --minify -o jsonpath='{.clusters[0].name}')"
```
9. Add your application:

```bash
argocd app create nginx-demo \                                                
--repo https://github.com/CryptoRodeo/rhtap-dev-get-started.git \
--path ./ArgoCD \
--dest-server "$(kubectl config view --minify -o jsonpath='{.clusters[0].cluster.server}')"
```

10. Confirm that your application is live on ArgoCD
```bash
argocd app list
```

11. Run a sync
```bash
argocd app sync nginx-demo
```

12. Monitor the deployment
```bash
argocd app get nginx-demo
kubectl get po -n demo-apps 
```

## Configuring Backstage

### App Config

In your plugin's `app-config.local.yaml` file (create one if it doesn't exist) add the following:
```yaml
argocd:
  localDevelopment: true
  username: admin
  # Get admin password: kubectl -n argocd get secret argocd-initial-admin-secret -o jsonpath="{.data.password}" | base64 -d
  password: <admin-password>
  appLocatorMethods:
    - type: 'config'
      instances:
        - name:  minikube
          # Get K8s URL: kubectl config view --minify -o jsonpath='{.clusters[0].cluster.server}
          url: <k8s-server-url>
```

### Component

For your Component's definition you can add the following:
```yaml
apiVersion: backstage.io/v1alpha1
kind: Component
metadata:
  name: redhat-argocd-app
  annotations:
    argocd/instance-name: minikube
    argocd/app-name: rhtap-demo
spec:
  type: service
  lifecycle: experimental
  owner: guests
  system: examples
  providesApis: [example-grpc-api]
```
