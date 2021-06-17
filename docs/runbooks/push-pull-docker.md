# How to Push and Pull Docker Images from an ECR repo

## Context

Some of the app teams need access to ECR repos to push and pull images manually as they set up their CI pipelines. These are the manual instructions to use for a CI user (i.e. permissions restricted to a specific ECR repo).

## How to Authenticate and Authorize to Use Docker

[AWS instructions](https://docs.aws.amazon.com/AmazonECR/latest/userguide/registry_auth.html)

Command to auth to use docker: 
 ```
 aws ecr get-login-password --region <REGION> | docker login --username AWS --password-stdin <ACCOUNT_ID>.dkr.ecr.<REGION>.amazonaws.com/<ECR_REPO>
 ```

 Example: 
```
aws ecr get-login-password --region us-east-1 | docker login --username AWS --password-stdin 802093990117.dkr.ecr.us-east-1.amazonaws.com/eec
```

## How to Tag and Push an Image

[AWS instructions](https://docs.aws.amazon.com/AmazonECR/latest/userguide/docker-push-ecr-image.html)

We recommend the tagging convention of system:githubHash (i.e. eec:d6cd1e2bd19e03a81132a23b2025920577f84e37).

Command to tag your image: 
```
docker tag <IMAGE_ID> <ACCOUNT_ID>.dkr.ecr.<REGION>.amazonaws.com/<TAG>
```

Example: 
```
docker tag 1234567 802093990117.dkr.ecr.us-east-1.amazonaws.com/eec:test
```

Command to push your tagged image to your repo: 
```
docker push <ACCOUNT_ID>.dkr.ecr.<REGION>.amazonaws.com/<TAG>
```
Example: 
```
docker push 802093990117.dkr.ecr.us-east-1.amazonaws.com/eec:test
```

## How to Pull an Image
[AWS instructions](https://docs.aws.amazon.com/AmazonECR/latest/userguide/docker-pull-ecr-image.html)

Command to examine your tagged image: 
```
aws ecr describe-images --repository-name <ECR_REPO> --region <REGION>
```

Example: 
```
aws ecr describe-images --repository-name eec --region us-east-1
```

Command to pull your tagged image: 
```
docker pull <ACCOUNT_ID>.dkr.ecr.<REGION>.amazonaws.com/<TAG>
```
Example: 
```
docker pull 802093990117.dkr.ecr.us-east-1.amazonaws.com/eec:test
```
