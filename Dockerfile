ARG SUSHI_VERSION=

### SUSHI ALPINE
FROM mcr.microsoft.com/devcontainers/base:alpine as fsh-sushi-alpine
RUN apk update \
    && apk add nodejs npm
# Update sources for nodejs
# RUN curl -fsSL https://deb.nodesource.com/setup_18.x | sudo -E bash -
# RUN apt update \
#     && apt install -y \
#     nodejs
ARG SUSHI_VERSION=
RUN npm install -g fsh-sushi@${SUSHI_VERSION}

### SUSHI UBUNTU
FROM mcr.microsoft.com/devcontainers/base:ubuntu as fsh-sushi-ubuntu
# Update sources for nodejs
RUN curl -fsSL https://deb.nodesource.com/setup_18.x | sudo -E bash -
RUN apt update \
    && apt install -y \
    nodejs
ARG SUSHI_VERSION=
RUN npm install -g fsh-sushi@${SUSHI_VERSION}

### PUB BASE ALPINE
FROM ghcr.io/cybernop/vscode-fhir-devcontainer/fsh-sushi:${SUSHI_VERSION}-alpine AS pub-base-alpine
RUN apk update \
    && apk add --no-cache \
    linux-headers \
    openjdk17-jdk \
    ruby-dev \
    msttcorefonts-installer \
    fontconfig
RUN gem install jekyll
RUN update-ms-fonts
RUN wget -q -P /workspaces https://raw.githubusercontent.com/HL7/ig-publisher-scripts/main/_updatePublisher.sh \
    && chmod a+x /workspaces/_updatePublisher.sh
RUN wget -q -P /workspaces https://github.com/hapifhir/org.hl7.fhir.core/releases/latest/download/validator_cli.jar \
    && printf "#!/bin/bash\njava -jar ../validator_cli.jar -html-output validation.html fsh-generated/resources" >> /workspaces/validate.sh \
    && chmod a+x /workspaces/validate.sh

### RUB BASE UBUNTU
FROM ghcr.io/cybernop/vscode-fhir-devcontainer/fsh-sushi:${SUSHI_VERSION}-ubuntu AS pub-base-ubuntu
RUN apt update \
    && apt install -y \
    openjdk-17-jdk \
    ruby-full \
    build-essential \
    zlib1g-dev
RUN gem install jekyll
RUN wget -q -P /workspaces https://raw.githubusercontent.com/HL7/ig-publisher-scripts/main/_updatePublisher.sh \
    && chmod a+x /workspaces/_updatePublisher.sh
RUN wget -q -P /workspaces https://github.com/hapifhir/org.hl7.fhir.core/releases/latest/download/validator_cli.jar \
    && printf "#!/bin/bash\njava -jar ../validator_cli.jar -html-output validation.html fsh-generated/resources" >> /workspaces/validate.sh \
    && chmod a+x /workspaces/validate.sh

### IG PUBLISHER ALPINE
FROM ghcr.io/cybernop/vscode-fhir-devcontainer/pub-base:alpine as ig-publisher-alpine
ARG SUSHI_VERSION=
RUN npm install -g fsh-sushi@${SUSHI_VERSION}

### IG PUBLISHER UBUNTU
FROM ghcr.io/cybernop/vscode-fhir-devcontainer/pub-base:ubuntu as ig-publisher-ubuntu
ARG SUSHI_VERSION=
RUN npm install -g fsh-sushi@${SUSHI_VERSION}
