# Tekton

Bootstraps a basic pipeline for local testing.

Make sure you have [Minikube](https://minikube.sigs.k8s.io/docs/start/?arch=%2Flinux%2Fx86-64%2Fstable%2Fbinary+download) installed.

## Setup

Install Tekton: https://tekton.dev/docs/installation/pipelines/

```bash
# Example
kubectl apply --filename https://storage.googleapis.com/tekton-releases/pipeline/latest/release.yaml
```

Apply the manifest file `manifest.yml`
```bash
kubectl apply -f manifest.yml
```
Run the pipeline
```bash
tkn pipeline start simple-pipeline -n tekton-pipelines
```

View the pipeline run to confirm a successful run
```bash
tkn pipelinerun logs simple-pipeline-run-<hash> -f -n tekton-pipelines
```
