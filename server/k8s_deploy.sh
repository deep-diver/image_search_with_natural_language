## Docker build and push ## 
# We are inside the `server` directory
$ docker build -t gcr.io/${PROJECT_ID}/search_service .
$ docker push gcr.io/${PROJECT_ID}/search_service

## Deploy on a GKE cluster ##
# Configure the Docker command-line tool to authenticate to Container Registry
$ gcloud auth configure-docker

# Create a Kubernetes cluster
$ gcloud container clusters create image-search-nlp 

# Create a deployment
$ kubectl create deployment clip-search --image=gcr.io/${PROJECT_ID}/search_service

# Number of worker replicas
$ kubectl scale deployment clip-search --replicas=3

# HorizontalPodAutoscaler resource
$ kubectl autoscale deployment clip-search --cpu-percent=80 --min=1 --max=5

# Expose deployment
$ kubectl  expose deployment clip-search --name=clip-search-service --type=LoadBalancer\    
    --port 80 --target-port 8080
