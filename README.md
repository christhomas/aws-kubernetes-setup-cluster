# kubernetes-aws-kops
A docker compose setup for initialising kubernetes to install on an AWS cluster

This docker container will install and configure kops and kubectl for setting up an AWS Cluster.  You can provide your aws credentials, ssh credentials and kube-config files in separately directories, provide some environment variables as noted in the docker-compose.yml and quickly install the cluster and gain access to it.

Usage Instructions:
- docker-compose run kops-eu-west-1 install
- docker-compose run kops-eu-west-1 create-hosted-zone mydomain.com
- docker-compose run kops-eu-west-1 uninstall [--delete-hosted-zone]

Problems:
- if docker build does not work because of permissions, its because the container created files with the wrong user:group, run 'fix_perms.sh'
- if validate-cluster does not immediately work, it can be because the cluster is not ready yet, it has taken 10 minutes for me in the past, run 'validate-cluster' periodically until it works
- Each time you delete and create a new hosted zone, you will get new DNS nameservers, meaning you will need to update your DNS nameservers at your registrar, that is why hosted zones are not deleted by default

### YOU PROBABLY SHOULD NOT USE THIS FOR YOUR PRODUCTION CLUSTER!
