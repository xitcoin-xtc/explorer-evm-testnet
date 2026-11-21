#!/bin/sh
set -eu
apk add --no-cache alpine-sdk gmp-dev automake libtool inotify-tools autoconf python3 file gcompat libstdc++ curl ca-certificates git make bash jq
apk info -v > /work/evidence/builder-apk-versions.txt
cd /app
mix local.rebar --force
mix deps.get --only prod
cp dependency-patches/ezstd-qualified-source/Makefile deps/ezstd/Makefile
cp dependency-patches/ezstd-qualified-source/build_deps.sh deps/ezstd/build_deps.sh
mix deps.compile --skip-umbrella-children
mix compile
mix release blockscout
cp config/config_helper.exs _build/prod/rel/blockscout/config/config_helper.exs
cp config/config_helper.exs _build/prod/rel/blockscout/releases/11.2.8/config_helper.exs
mkdir -p _build/prod/rel/blockscout/config/assets
cp config/assets/precompiles-arbitrum.json _build/prod/rel/blockscout/config/assets/
apk info -v > /work/evidence/builder-apk-versions-final.txt
