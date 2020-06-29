FROM mcr.microsoft.com/powershell:latest

# install sfdx tool to /usr/local/bin and ~/.local/share/sfdx/cli/
RUN export DEBIAN_FRONTEND=noninteractive \
    && apt-get update -y \
    && apt-get install -y --no-install-recommends \
    xz-utils nodejs gnupg curl ca-certificates apt-transport-https \
    && cd /tmp \
    && export SFDX_DEBUG=1 \
    && curl -sL https://developer.salesforce.com/media/salesforce-cli/sfdx-linux-amd64.tar.xz | tar xJ \
    && ./sfdx*/install \
    && rm -rf ./sfdx* \
    && sfdx update

RUN curl -sSfL https://apt.octopus.com/public.key | apt-key add - \
    && sh -c "echo deb https://apt.octopus.com/ stable main > /etc/apt/sources.list.d/octopus.com.list" \
    && apt-get update -y && apt-get install -y --no-install-recommends octopuscli

ENV SFDX_AUTOUPDATE_DISABLE=true SFDX_USE_GENERIC_UNIX_KEYCHAIN=true SFDX_DOMAIN_RETRY=300
