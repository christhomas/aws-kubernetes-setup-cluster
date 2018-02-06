# kubernetes-aws-kops
A docker compose setup for initialising kubernetes to install on an AWS cluster

This docker container will install and configure kops and kubectl for setting up an AWS Cluster.  You can provide your aws credentials, ssh credentials and kube-config files in separately directories, provide some environment variables as noted in the docker-compose.yml and quickly install the cluster and gain access to it.

## Usage Instructions:
### To get a shell on the container
- docker-compose run kops-burning-candle sh
- init-cluster
- destroy-cluster [--delete-hosted-zone]
- create-cluster k8s.burning-candle.com eu-west-1 burning-candle.com
- create-s3-bucket burning-candle-kops-config eu-west-1 
- create-hosted-zone mydomain.com
- delete-cluster k8s.burning-candle.com
- delete-hosted-zone mydomain.com
- empty-route53-hosted-zone <ZONE_ID>
- empty-s3-bucket burning-candle-kops-config
- configure-domain-elb default/hello-node burning-candle.com

## Questions:
#### - Why is there a destroy-cluster and delete-cluster
destroy cluster takes down all the related resources whilst delete-cluster is a kops operation to just delete the cluster on aws, but nothing else
#### - Why is the domain and cluster variables different? e.g: burning-candle.com ($DOMAIN) and k8s.burning-candle.com $(CLUSTER)
When kops creates the cluster, it also creates a number of other subdomains, for example api.$CLUSTER and api.internal.$CLUSTER, if you set the domain and cluster variables to the same value, it would effectively create api.$DOMAIN, which might conflict with any api you would want to install on the website, meaning you'd be setting up the cluster in a domain which you might want to use for a legitimate website api, so by giving $CLUSTER a value of the domain k8s.$DOMAIN, then you effectively namespace kubernetes cluster into a section of the domain namespace which you are almost guaranteed to never have a conflict. This isn't a hard requirement, but it's probably a good idea. 

## Problems:
- if docker build does not work because of permissions, its because the container created files with the wrong user:group, run 'fix_perms.sh'
- if validate-cluster does not immediately work, it can be because the cluster is not ready yet, it has taken 10 minutes for me in the past, run 'validate-cluster' periodically until it works
- Each time you delete and create a new hosted zone, you will get new DNS nameservers, meaning you will need to update your DNS nameservers at your registrar, that is why hosted zones are not deleted by default

### YOU PROBABLY SHOULD NOT USE THIS FOR YOUR PRODUCTION CLUSTER!
