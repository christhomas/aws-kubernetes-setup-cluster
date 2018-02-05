FROM alpine:edge

ENV KUBE_LATEST_VERSION="v1.9.2"
ENV BIN=/usr/local/bin
ENV KOPS=https://github.com/kubernetes/kops/releases/download/1.7.0/kops-linux-amd64
ENV KUBECTL=https://storage.googleapis.com/kubernetes-release/release/${KUBE_LATEST_VERSION}/bin/linux/amd64/kubectl

# Install AWS CLI, Kubectl, Kops
RUN apk -v --no-cache --update add \
    python py-pip \
    curl ca-certificates \
    groff less jq util-linux \
    openssh-client

RUN pip install awscli

RUN curl -L ${KOPS} -o ${BIN}/kops
RUN curl -L ${KUBECTL} -o ${BIN}/kubectl
ADD ./scripts/* ${BIN}/
ADD ./entrypoint.sh /
RUN chmod +x /entrypoint.sh ${BIN}/*

ENTRYPOINT ["/entrypoint.sh"]
CMD ["/bin/sh"]