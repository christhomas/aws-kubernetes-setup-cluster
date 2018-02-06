# kubernetes-aws-kops
A docker compose setup for initialising kubernetes to install on an AWS cluster

This docker container will install and configure kops and kubectl for setting up an AWS Cluster.  You can provide your aws credentials, ssh credentials and kube-config files in separately directories, provide some environment variables as noted in the docker-compose.yml and quickly install the cluster and gain access to it.

## Usage Instructions:
- docker-compose run kops-burning-candle init-cluster
- docker-compose run kops-burning-candle destroy-cluster [--delete-hosted-zone]
- docker-compose run kops-burning-candle create-cluster k8s.burning-candle.com eu-west-1 burning-candle.com
- docker-compose run kops-burning-candle create-s3-bucket burning-candle-kops-config eu-west-1 
- docker-compose run kops-burning-candle create-hosted-zone mydomain.com
- docker-compoes run kops-burning-candle delete-cluster k8s.burning-candle.com
- docker-compoes run kops-burning-candle delete-hosted-zone mydomain.com
- docker-compose run kops-burning-candle empty-route53-hosted-zone <ZONE_ID>
- docker-compose run kops-burning-candle empty-s3-bucket burning-candle-kops-config
- docker-compose run kops-burning-candle configure-domain-elb default/hello-node burning-candle.com

## Questions:
#### - Why is there a destroy-cluster and delete-cluster
destroy cluster takes down all the related resources whilst delete-cluster is a kops operation to just delete the cluster on aws, but nothing else 

## Problems:
- if docker build does not work because of permissions, its because the container created files with the wrong user:group, run 'fix_perms.sh'
- if validate-cluster does not immediately work, it can be because the cluster is not ready yet, it has taken 10 minutes for me in the past, run 'validate-cluster' periodically until it works
- Each time you delete and create a new hosted zone, you will get new DNS nameservers, meaning you will need to update your DNS nameservers at your registrar, that is why hosted zones are not deleted by default

### YOU PROBABLY SHOULD NOT USE THIS FOR YOUR PRODUCTION CLUSTER!
