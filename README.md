# HelloJava



# Build & test locally
docker build -t hello-java:1.0 .
docker run -p 8080:8080 -e MESSAGE="Hello from my laptop" hello-java:1.0
# curl http://localhost:8080

# (Optional) Create ECR repo
aws ecr create-repository --repository-name hello-java || true

# Login to ECR
aws ecr get-login-password --region REGION | \
  docker login --username AWS --password-stdin ACCOUNT_ID.dkr.ecr.REGION.amazonaws.com

# Tag & push
docker tag hello-java:1.0 ACCOUNT_ID.dkr.ecr.REGION.amazonaws.com/hello-java:1.0
docker push ACCOUNT_ID.dkr.ecr.REGION.amazonaws.com/hello-java:1.0

# Apply k8s manifests (after updating image in the YAML below)
kubectl apply -f hello-k8s.yaml

# Verify
kubectl get deploy,po,svc -l app=hello-java
# If Service type=LoadBalancer, grab EXTERNAL-IP and:
# curl http://EXTERNAL_IP:80
