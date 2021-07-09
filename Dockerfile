FROM mcr.microsoft.com/powershell:latest

# install sfdx tool to /usr/local/bin and ~/.local/share/sfdx/cli/
RUN export DEBIAN_FRONTEND=noninteractive \
    && apt-get update -y \
    && apt-get install -y --no-install-recommends \
    xz-utils git gnupg  dirmngr lsb-release curl ca-certificates apt-transport-https gcc g++ make \
    && cd /tmp \
    && curl -sL https://deb.nodesource.com/setup_12.x | bash - \
    && apt-get update \
    && apt-get -y install nodejs
    
RUN export SFDX_DEBUG=1 \
    && npm install sfdx-cli@7.109.0 --global \
    && sfdx --version

RUN curl -sSfL https://apt.octopus.com/public.key | apt-key add - \
    && sh -c "echo deb https://apt.octopus.com/ stable main > /etc/apt/sources.list.d/octopus.com.list" \
    && apt-get update -y && apt-get install -y --no-install-recommends octopuscli

ENV SFDX_AUTOUPDATE_DISABLE=true SFDX_USE_GENERIC_UNIX_KEYCHAIN=true SFDX_DOMAIN_RETRY=300
