
# Wordpress AWS Ecs Fargate

This is ready for deploy Aws ecs fargate container.
## Dependencies

    1. AWS account.

    2. aws cli installed.

    3. Terraform installed.
## Installation

Install my-project by running this commands:

```
- creating the project folder:
    mkdir ${name-of-your-project}
    cd ${name-of-your-project}

- clone the github repository:
    git init
    git clone https://github.com/mamialex/wordpress.git

- set up your AWS CLI (provide your user Access key and Secret access key):
    aws config
```
    
## Deployment

To deploy this project run:

```
- initialize terraform and deploy:
    terraform init
    terraform apply

- Push commands for ecr-repo:
    aws ecr get-login-password --region eu-west-2 | docker login --username AWS --password-stdin 809006919682.dkr.ecr.eu-west-2.amazonaws.com
    docker build -t ecr-repo .
    docker tag ecr-repo:latest 809006919682.dkr.ecr.eu-west-2.amazonaws.com/ecr-repo:latest
    docker push 809006919682.dkr.ecr.eu-west-2.amazonaws.com/ecr-repo:latest
```


## Usage

```
Grab the DNS name from the created load balancer and open it in a browser.
```

