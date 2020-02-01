FROM debian:buster-slim

RUN \
	apt-get update \
	&& apt-get dist-upgrade -y --no-install-recommends \
  && apt-get install -y build-essential \
	  libssl-dev \
	  python-dev \
	  libffi-dev \
    zlib-devel \
  && apt-get clean \
	&& rm -rf /tmp/* /var/tmp/* \
	&& rm -rf /var/lib/apt/lists/* \
  && useradd duo

ARG VERSION

# Build and install authproxy.
ADD https://dl.duosecurity.com/duoauthproxy-${VERSION}-src.tgz /root/
COPY build /root/
RUN /root/build
