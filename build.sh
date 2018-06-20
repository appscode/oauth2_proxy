#!/bin/bash
set -x
set -euo pipefail

pushd $GOPATH/src/github.com/bitly/oauth2_proxy

docker build -t appscode/oauth2_proxy:2.2.0 .
docker push appscode/oauth2_proxy:2.2.0

popd
