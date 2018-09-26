FROM alpine:edge

# Note: Latest version of kubectl may be found at:
# https://storage.googleapis.com/kubernetes-release/release/stable.txt
ENV KUBE_LATEST_VERSION="v1.10.4"
# Note: Latest version of helm may be found at:
# https://github.com/kubernetes/helm/releases
ENV HELM_LATEST_VERSION="v2.9.1"
# Note: Latest version of kops may be found at:
# https://github.com/kubernetes/kops/releases
ENV KOPS_LATEST_VERSION="1.8.1"

ENV BIN=/usr/local/bin
ENV KOPS=https://github.com/kubernetes/kops/releases/download/${KOPS_LATEST_VER}/kops-linux-amd64
ENV KUBECTL=https://storage.googleapis.com/kubernetes-release/release/${KUBE_LATEST_VERSION}/bin/linux/amd64/kubectl
ENV HELM=http://storage.googleapis.com/kubernetes-helm/helm-${HELM_LATEST_VERSION}-linux-amd64.tar.gz

# Install AWS CLI, Kubectl, Kops
RUN apk -v --no-cache --update add \
    python py-pip \
    curl ca-certificates \
    groff less jq util-linux \
    openssh-client bind-tools

RUN pip install awscli

RUN curl -L ${KOPS} -o ${BIN}/kops
RUN curl -L ${KUBECTL} -o ${BIN}/kubectl
RUN curl -L ${HELM} | tar xzO linux-amd64/helm > ${BIN}/helm
ADD ./scripts/* ${BIN}/
ADD ./entrypoint.sh /
RUN chmod +x /entrypoint.sh ${BIN}/*

ENTRYPOINT ["/entrypoint.sh"]
CMD ["/bin/sh"]