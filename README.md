
# Wordpress AWS ECS Fargate

Container-based architecture deployable through Terraform.

AWS Codepipeline not included in Terraform.
![alt text](https://cdn.discordapp.com/attachments/363068637608804363/1033873807691239604/Wordpress_2.jpg)

[Click here for an extremely weird and detailed diagram generated with Terraform graph](https://github.com/mamialex/wordpress/blob/main/graph/graph.svg)
## Installation

Deploy the project by following these steps:

```
- clone the github repository:
    git clone https://github.com/mamialex/wordpress.git
```
    
## Deployment

To deploy this project run:

```
- initialize terraform and deploy:
    terraform init
    terraform apply

- Push commands for ecr-repo:
    aws ecr get-login-password --region ${REGION} | docker login --username AWS --password-stdin ${ACCOUNT_ID}.dkr.ecr.${REGION}.amazonaws.com
    docker build -t ecr-repo .
    docker tag ecr-repo:latest ${ACCOUNT_ID}.dkr.ecr.${REGION}.amazonaws.com/ecr-repo:latest
    docker push ${ACCOUNT_ID}.dkr.ecr.${REGION}.amazonaws.com/ecr-repo:latest
```


## Pipeline

Not included in Terraform (but present in my own account) is a pipeline that will pull, build and deploy the Docker container running Wordpress.




## Usage

```
Grab the DNS name from the created load balancer and open it in a browser.
```

