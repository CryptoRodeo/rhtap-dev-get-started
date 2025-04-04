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

3. Wait for ArgoCD to finish installing
```bash
kubectl wait --for=condition=Ready pods --all -n argocd --timeout=300s
```

4. Expose ArgoCD server
```bash
kubectl patch svc argocd-server -n argocd -p '{"spec": {"type": "NodePort"}}'
```

5. Apply sample applications
```bash
kubectl apply -f https://raw.githubusercontent.com/CryptoRodeo/rhtap-dev-get-started/refs/heads/argocd-docs/Configuration/ArgoCD/argocd-apps.yml
```

6. Get the K8s server URL and ArgoCD service port
```bash
# K8s server URL, remove the port at the end.
# It may not be the first one listed. Change the index if needed.
kubectl config view -o jsonpath='{.clusters[0].cluster.server}'

# ArgoCD Service port
kubectl get svc argocd-server -n argocd -o jsonpath='{.spec.ports[0].nodePort}'
```

7. Access the ArgoCD UI
Grab the default admin password:
```bash
kubectl -n argocd get secret argocd-initial-admin-secret -o jsonpath="{.data.password}" | base64 -d
```

url should be `https://<k8s-server-url>:<argocd-svc-port>`
username should be `admin`

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
          # Get K8s URL: kubectl config view --minify -o jsonpath='{.clusters[0].cluster.server}'
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
