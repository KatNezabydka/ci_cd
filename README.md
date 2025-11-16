# 🚀 CI/CD for Django on EKS with Helm

This project demonstrates how to deploy a Django application on AWS EKS using Terraform, Docker, ECR, and Helm.

---

## Terraform Setup (EKS + Node Group)

1. Go to the Terraform directory:

```
cd terraform
```

2. Initialize Terraform:

```
terraform init
```

3. Preview the deployment plan:

```
terraform plan
```

4. Apply the Terraform configuration:

```
terraform apply
```

5. Destroy terraform:

```
terraform destroy
```

6. Configure your kubeconfig for access:

```
aws eks --region {region} update-kubeconfig --name {cluster-name}
kubectl get nodes
```

If nodes show Ready, your cluster is ready.

## Build Docker Image and Push to ECR

1. Authenticate Docker with AWS ECR:

```
aws ecr get-login-password --region {region} | docker login --username AWS --password-stdin {host}
```

2. Build your Docker image:

```
docker build -t hw-ecr .
```

3. Tag your image so you can push the image to this repository:

```
docker tag hw-ecr:latest {host}/hw-ecr:latest
```

4. Run the following command to push this image to your newly created AWS repository:

```
docker push {host}/hw-ecr:latest
```

## Build Docker Image and Push to ECR (if you have macOS)

```
docker buildx build --platform linux/amd64 -t {host}/hw-ecr:latest --push .
```

## Deploy Django with Helm

1. Install the Helm chart:

 ```
helm install django-app ./charts/django-app
```

2. Upgrade the Helm chart:

 ```
helm upgrade django-app ./charts/django-app
```

!!! For upgrade the Helm chart with the correct name:

```
helm upgrade --install django-app ./charts/django-app -f ./charts/django-app/values.yaml
 ```

!!! RUN on localhost:8000

```
kubectl port-forward svc/django-app-django 8000:80
```

3. Check the Pods:

 ```
kubectl get pods -l app=django-app-django
 ```

4. Check the Service:

 ```
kubectl get svc django-app-django
 ```

After all we can delete our cluster:

 ```
helm delete django-app
 ```

And destroy all resources:

```
terraform destroy
 ```

# EKS

For EKS cluster we need to get kubeconfig file

`aws eks --region eu-central-1 update-kubeconfig --name eks-lesson8-9-cluster`

Check if it is working:

`kubectl get nodes`

After this we can comment our providers in main.tf file
and use the local config:

```hcl
provider "kubernetes" {
  config_path = "~/.kube/config"
}

provider "helm" {
  kubernetes = {
    config_path = "~/.kube/config"
  }
}
```

# Jenkins

Jenkins we autoconfigure using the JCasC

# ArgoCD

ArgoCD we autoconfigure using the helm chart
In the argocd module we provide values.yaml file with the values for the chart to add application automatically
