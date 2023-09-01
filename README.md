# CNTF - Custom UERANSIM Docker Image

## Purpose
This source code repository stores the configurations to create a custom UERANSIM docker image. This custom image includes scripts from Pupeteer (https://github.com/puppeteer/puppeteer), which enables additional capabilites to be included in the UERANSIM test-suite.

## AWS Elastic Container Registry
* In the event that these images are not stored in an existing image repository, please create a new AWS ECR repository for the custom image(s) to be uploadeded & stored: 
    * Step 1 - Create an ECR repository: https://docs.aws.amazon.com/AmazonECR/latest/userguide/repository-create.html
    * Step 2 - In the ".gitlab-ci.yml" file, change line 5 to represent the repository registry URL for your AWS ECR repository

## Deployment
Prerequisites:

* *Please ensure that you have configured the AWS CLI to authenticate to an AWS environment where you have adequate permissions to create an EKS cluster, security groups and IAM roles*: https://docs.aws.amazon.com/cli/latest/userguide/getting-started-quickstart.html
* *Please ensure that the "CNTF-Main" branch has been deployed, as this ensures that the cluster and other necessary AWS infrastructure are available to support the execution of scripts in this repository.*  
** Please ensure that there is an existing image repository for these cusotm docker images to be stored.*


Steps:
1. Mirror this repository in Gitlab or connect this repository externally to Gitlab 
2. Authenticate Gitlab with AWS: https://docs.gitlab.com/ee/ci/cloud_deployment/
3. In Gitlab, click the drop-down arrow next to "Build" and select "Pipelines"
4. In the top right hand corner select "Run Pipeline"
5. In the drop-down under "Run for branch name or tag" select the appropriate name for this branch and click "Run Pipeline"
6. Once again, click the drop-down arrow next to "Build" and select "Pipelines", you should now see the pipeline being executed

## Project Structure:
```
├── open5gs                          contains infrastructure-as-code and helm configurations for open5gs
│   ├── infrastructure
|      	├── eks
|           └── provider.tf
|           └── main.tf
|           └── variables.tf
|           └── outputs.tf 
|   ├── application
|	      └── README.md
|	     
├── free5gc                          contains infrastructure-as-code and helm configurations for free5gc
|   ├── infrastructure
|       ├── eks
|           └── provider.tf
|           └── main.tf
|           └── variables.tf
|           └── outputs.tf 
|
|   ├── application
|       └── README.md
|
├── magma                            contains infrastructure-as-code and helm configurations for magma
|   ├── infrastructure
|       ├── eks
|           └── provider.tf
|           └── main.tf
|           └── variables.tf
|           └── outputs.tf 
|    
|   ├── application
|       └── README.md
```
