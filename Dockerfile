FROM gcr.io/cloud-marketplace-tools/k8s/deployer_envsubst:latest

# Update apt
RUN apt-get -y update
RUN apt-get -y upgrade

# Install curl
RUN apt-get -y install curl

# Install openssl
RUN apt-get -y install openssl

# Install gcloud
RUN apt-get -y install gnupg2
RUN apt-get -y install lsb-release
RUN export CLOUD_SDK_REPO="cloud-sdk-$(lsb_release -c -s)" && \
    echo "deb http://packages.cloud.google.com/apt $CLOUD_SDK_REPO main" | tee -a /etc/apt/sources.list.d/google-cloud-sdk.list && \
    curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key add - && \
    apt-get update -y && apt-get install google-cloud-sdk -y

# Download repo files
RUN apt-get -y install git
RUN git clone https://github.com/cloudbees/core-google-launcher.git

COPY deployer/create_manifests.sh /bin/
COPY deployer/deploy.sh /bin/
COPY schema.yaml /data/
COPY server.config /data/
COPY manifest /data/manifest
COPY manifest-ingress /data/manifest-ingress

ENTRYPOINT ["/bin/bash", "/bin/deploy.sh"]
