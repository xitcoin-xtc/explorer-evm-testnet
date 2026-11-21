FROM hexpm/elixir@sha256:c129490fa75f7d00a28e293eb8ee5e00d1b7b34da03748b998369e41ef8a0a1e
WORKDIR /app
RUN apk add --no-cache jq curl libstdc++ gmp gcompat && addgroup -S -g 10001 blockscout && adduser -S -D -H -u 10001 -G blockscout blockscout
ENV DISABLE_WEBAPP=true ADMIN_PANEL_ENABLED=false CHAIN_TYPE=default RELEASE_VERSION=11.2.8 BLOCKSCOUT_VERSION=11.2.8
COPY --chown=10001:10001 backend/_build/prod/rel/blockscout/ /app/
RUN mkdir -p /app/dets /app/temp && chown 10001:10001 /app/dets /app/temp
USER 10001:10001
CMD ["bin/blockscout", "start"]
LABEL xitcoin.mission=20260913T0911 org.opencontainers.image.version=11.2.8
