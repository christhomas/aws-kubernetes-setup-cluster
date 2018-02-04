# aws-kubernetes-setup-cluster
A docker compose setup for initialising kubernetes to install on an AWS cluster

This docker container will install and configure kops and kubectl for setting up an AWS Cluster.  You can provide your aws credentials, ssh credentials and kube-config files in separately directories, provide some environment variables as noted in the docker-compose.yml and quickly install the cluster and gain access to it.

Usage Instructions:
- docker-compose run kops-eu-west-1 install
- docker-compose run kops-eu-west-1 create-hosted-zone mydomain.com
- docker-compose run kops-eu-west-1 uninstall [--delete-hosted-zone]

YOU PROBABLY SHOULD NOT USE THIS FOR YOUR PRODUCTION CLUSTER!
