FROM debian:buster-slim

RUN \
    apt-get update \
    && apt-get dist-upgrade -y --no-install-recommends \
    && apt-get install -y \
      python \
      openssl \
    && apt-get clean \
  	&& rm -rf /tmp/* /var/tmp/* \
  	&& rm -rf /var/lib/apt/lists/* \
    && useradd -s /sbin/nologin duo

# Use ADD, not COPY, to keep image small.
ADD duoauthproxy.tgz /

COPY harden /usr/sbin/harden
# RUN /usr/sbin/harden

RUN mkdir -p /opt/duoauthproxy/log; \
    chown -R duo:duo /opt/duoauthproxy/log
VOLUME /opt/duoauthproxy/log

COPY authproxy.cfg /etc/duoauthproxy/authproxy.cfg
USER duo
ENTRYPOINT ["/opt/duoauthproxy/bin/authproxy"]
VOLUME /opt/duoauthproxy/conf/

ARG CI_BUILD_URL
ARG BUILD_DATE
ARG VCS_REF
ARG VERSION

LABEL \
    io.github.jumanjiman.ci-build-url=$CI_BUILD_URL \
    io.github.jumanjiman.version=$VERSION \
    io.github.jumanjiman.build-date=$BUILD_DATE \
    io.github.jumanjiman.vcs-ref=$VCS_REF \
    io.github.jumanjiman.license="MIT" \
    io.github.jumanjiman.docker.dockerfile="/runtime/Dockerfile" \
    io.github.jumanjiman.vcs-type="Git" \
    io.github.jumanjiman.vcs-url="https://github.com/jumanjihouse/docker-duoauthproxy.git"
