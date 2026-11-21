# Build recipes

How the explorer images that run were built (13/09/2026). Details and upstream versions: [`../docs/BLOCKSCOUT_IMAGE_PROVENANCE.md`](../docs/BLOCKSCOUT_IMAGE_PROVENANCE.md).

| Path | Image |
|---|---|
| `backend/build-backend.sh` | compiles Blockscout 11.2.8 from source (run in an Elixir builder, source tree in `/app`) |
| `backend/Dockerfile` | packages the compiled release → `xitcoin-private/backend:20260913T0911` |
| `backend/dependency-patches/` | one-CPU build of the `ezstd` dependency, with the expected file hashes |
| `frontend/runtime.Dockerfile` + `frontend/launch-frontend.cjs` | Node base + production build of the Blockscout frontend (`frontend-corrected-runtime.tar.gz`, on the backup disk) |
| `frontend/sprite-overlay.Dockerfile` + `frontend/sprite.svg` | adds the icon sprite → `xitcoin-private/frontend:20260913T0911` |
| `../server/frontend-fix.Dockerfile` | 21/11/2026 fix → `xitcoin-private/frontend:20260913T0911-fix1` (the image in use) |
