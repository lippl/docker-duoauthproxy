#!/bin/bash
set -e

. script/functions

common_tag="duoauthproxy-common"
builder_tag="duoauthproxy-builder:${base_distro}"
runtime_tag="duoauthproxy:${base_distro}"

smitty pushd $base_distro
smitty docker build --rm -t $common_tag .
smitty popd

smitty pushd builder
smitty docker build --rm -t $builder_tag .
smitty popd

smitty pushd runtime
smitty rm -fr duoauthproxy.tgz || :
smitty docker run --rm -v $(pwd):/tmp $builder_tag bash -c "tar czf /tmp/duoauthproxy.tgz /opt/duoauthproxy"
smitty docker build --rm -t $runtime_tag .
smitty popd