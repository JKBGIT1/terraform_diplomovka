# IaaC for my Master's Thesis Implementation

## Description
The main goal of my Master's Thesis is to perform data deduplication in the data lake, specifically in the data ingestion phase. As a side project, I have developed this repository, which deploys the infrastructure of my Master's Thesis implementation to Kubernetes cluster with the usage of Terraform.

### Technologies
* Data ingestion - Kafka
* Storages - Redis, PostgreSQL and MINIO
* Uploading services - Flask
* Deployment - Docker, Kubernetes and Terraform

## How to run
### Prerequisites:
* Docker (I have used Docker Desktop v4.15.0)
* Kubernetes (I have used Kubernetes extension v1.25.2 in Docker Desktop)
* Terraform (I have used v1.3.6)
* NGINX Ingress controller: kubectl apply -f https://raw.githubusercontent.com/kubernetes/ingress-nginx/controller-v1.5.1/deploy/static/provider/cloud/deploy.yaml

### Steps to run:
* git clone https://github.com/JKBGIT1/terraform_diplomovka.git
* based on the .env.example files (in configmaps and secrets folders) you have to create your own .env files, which are used in k8s ConfigMaps and Secrets
* terraform init
* terraform apply -auto-approve

## How to use the project
The service for uploading files is exposed on http://localhost:80/file . If you want to upload the file to the running instace of the data lake, you have to invoke a POST request on http://localhost:80/file/upload . 
The body of this request should contain the file, which you want to upload to the data lake. This file should be located under "file" parameter, as you can see on the image under.

After successfull file upload, you can check on the url http://localhost:80/ , how the data lake processed the file. Because MINIO console is exposed on this url.

If you want to upload structured data to the data lake, you have invoke a POST request on http://localhost:80/structured-data/upload .
The body of this request should contain sql dump file, which will be processed by the data lake. This sql dump should be located under "sql_dump" parameter. In the end the unique data from this file dump will be stored in PostgreSQL technology.

Currently you can't check, through some fancy GUI, if the data were uploaded successfully, because I haven't yet added PGAdmin to this infrastructure. Again you can you Postman for uploading the structured data (see the image below).

## Future plans
Develop graphical interface for uploading the data and querying the data inside the data lake.
