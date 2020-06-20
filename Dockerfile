ARG IMAGE
ARG IMAGE_VERSION

FROM ${IMAGE}:${IMAGE_VERSION}

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update \
    && apt-get install -y --no-install-recommends \
    apt-transport-https \
    ca-certificates \
    curl \
    gnupg2 \
    gnupg-agent \
    software-properties-common \
    && curl -fsSL https://download.docker.com/linux/debian/gpg | apt-key add - \
    && add-apt-repository \
    "deb [arch=amd64] https://download.docker.com/linux/debian \
    $(lsb_release -cs) \
    stable" \
    && apt-get update \
    && apt-get install -y --no-install-recommends \
    docker-ce docker-ce-cli \
    containerd.io \
    && apt-get purge -y && apt-get autoremove -y && apt-get autoclean -y \
    && rm -rf /var/lib/apt/lists/*

RUN usermod -aG docker root \
    && newgrp docker

ENTRYPOINT ["/bin/sh", "-c"]

CMD ["bash"]
