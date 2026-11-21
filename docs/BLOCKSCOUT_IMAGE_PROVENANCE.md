# Blockscout image provenance

The images that run were built on the server on 13/09/2026, then the frontend was fixed on 21/11/2026. They are not pulled from a registry (`pull_policy: never`). A copy of every image is kept on the offline backup disk.

## Backend: `xitcoin-private/backend:20260913T0911`

- Upstream: https://github.com/blockscout/blockscout, release 11.2.8 (`RELEASE_VERSION=11.2.8`, `BLOCKSCOUT_VERSION=11.2.8`).
- Compiled from source with [`build/backend/build-backend.sh`](../build/backend/build-backend.sh) in an Elixir builder, then packaged by [`build/backend/Dockerfile`](../build/backend/Dockerfile) (`DISABLE_WEBAPP=true`, `ADMIN_PANEL_ENABLED=false`, user `10001`).
- Only change to upstream: the `ezstd` dependency is built with one CPU (`build/backend/dependency-patches/`), to fit the build machine. Expected file hashes are in `qualified-hashes.json`.

## Stats: `xitcoin-private/stats:20260913T0911`

- Upstream image of https://github.com/blockscout/blockscout-rs, `stats-v2.19.1`, revision `cd413c58c3469bdd442d0e7a0cebdaba79e641d5` (image labels), retagged locally. No change.

## Frontend: `xitcoin-private/frontend:20260913T0911-fix1`

Three layers:

1. [`build/frontend/runtime.Dockerfile`](../build/frontend/runtime.Dockerfile): a Node base image plus the production build of https://github.com/blockscout/frontend (archive `frontend-corrected-runtime.tar.gz`, kept on the backup disk because of its size) and [`launch-frontend.cjs`](../build/frontend/launch-frontend.cjs), which loads the public configuration and checks that the server and browser copies match.
2. [`build/frontend/sprite-overlay.Dockerfile`](../build/frontend/sprite-overlay.Dockerfile): adds the missing icon sprite `public/icons/sprite.svg` (tag `20260913T0911`).
3. [`server/frontend-fix.Dockerfile`](../server/frontend-fix.Dockerfile) (21/11/2026): adds the missing link from `@wagmi/core` to `@tanstack/query-core`; without it every `/address/` page returned error 500 (tag `20260913T0911-fix1`).

## Databases and cache

`postgres:17` (digest `sha256:e38411452a464af89e5adadb8d223bf53b898d47d6ef918b2d58c08707350449`) and `redis:7-alpine` (digest `sha256:e7723ff73d963f5cc6d9c4643ea3d989527a402a319239054e9472a7fb9219a2`), official images.

## History

Until August 2026 this repository described images built by a GitHub workflow (backend 11.2.7, frontend 2.10.3, published to the GitHub Container Registry). Those images were replaced on 13/09/2026 and are no longer used; the workflow was removed on 21/11/2026.
