# CNTF - Custom UERANSIM Docker Image

## Purpose
This source code repository stores the configurations to create a custom UERANSIM docker image. This custom image includes scripts from Pupeteer (https://github.com/puppeteer/puppeteer), which enables the UERANSIM test-suite to perform unique tests on a 5g network.

## AWS - Elastic Container Registry (ECR)
* In the event that the custom image(s) is not stored in an existing image repository, please create a new AWS ECR repository for them to be uploadeded & stored: 
    * Step 1 - Create an ECR repository: https://docs.aws.amazon.com/AmazonECR/latest/userguide/repository-create.html
    * Step 2 - In the ".gitlab-ci.yml" file, change line 5 to represent the repository registry URL for your AWS ECR repository

## Deployment
Prerequisites:

* *Please ensure that you have configured the AWS CLI to authenticate to an AWS environment where you have adequate permissions to create an EKS cluster, security groups and IAM roles*: https://docs.aws.amazon.com/cli/latest/userguide/getting-started-quickstart.html
* *Please ensure that the "CNTF-Main" branch has been deployed, as this ensures that the cluster and other necessary AWS infrastructure are available to support the execution of scripts in this repository.*  
* *Please ensure that there is an existing image repository where these cusotm docker images can be stored.*


Steps:
1. Mirror this repository in Gitlab or connect this repository externally to Gitlab 
2. Authenticate Gitlab with AWS: https://docs.gitlab.com/ee/ci/cloud_deployment/
3. Perform these actions inside of the Gitlab repository:
    * On the left side of the screen click the drop-down arrow next to "Build" and select "Pipelines"
    * In the top right hand corner select "Run Pipeline"
    * In the drop-down under "Run for branch name or tag" select the appropriate name for this branch and click "Run Pipeline"
    * Once again, click the drop-down arrow next to "Build" and select "Pipelines", you should now see the pipeline being executed

## Project Structure:
```
└── README.md
|
|
└── .gitlab-ci.yml             contains configurations to run CI/CD pipeline
|
|
└── Dockerfile                 contains the configurations to create the custom ueransim docker image
|   
|
└── amazon-search.js           contains configurations to simulate a search on amazon.com and can be inserted into the dockerfile to modify the ueransim test-suite
|
|
└── devtools-search.js         contains configurations to simulate a search on dev-tools.ai and can be inserted into the dockerfile to modify the ueransim test-suite
|
|
└── youtube-search.js          contains configurations to simulate watching a video on youtube.com and can be inserted into the dockerfile to modify the ueransim test-suite
```
