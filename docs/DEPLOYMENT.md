# Deployment

## Where it runs

- Server: `kcalb-platform-1`.
- Folder: `/srv/kcalb/applications/xitchain-evm-explorer` (mirrored in [`server/`](../server/)).
- Docker Compose project: `xitchain-evm-explorer`; volumes `xitchain-evm-explorer_backend_db`, `xitchain-evm-explorer_stats_db`, `xitchain-evm-explorer_redis_data`; networks `xitchain-evm-explorer_internal` (no internet) and `xitchain-evm-explorer_egress`.
- Ports, all on `127.0.0.1`: backend API `15100`, frontend `15101`, stats `15002`. Nginx on the host publishes `https://evm-explorer-testnet.xitchain.com` (stats under `/stats-service`).
- The backend indexes the chain from the testnet sentry node's EVM JSON-RPC.

## Services

| Service | Image | Role |
|---|---|---|
| `db` | `postgres:17` | Blockscout database `xitcoin_blockscout` |
| `stats-db` | `postgres:17` | stats database `stats` |
| `redis` | `redis:7-alpine` | cache |
| `backend` | `xitcoin-private/backend:20260913T0911` | Blockscout 11.2.8 indexer and API (`DISABLE_WEBAPP=true`, no exchange rates: testnet XTC has no price) |
| `stats` | `xitcoin-private/stats:20260913T0911` | Blockscout stats 2.19.1, configured by `stats.json`, `charts.json`, `layout.json`, `update-groups.json` |
| `frontend` | `xitcoin-private/frontend:20260913T0911-fix1` | Blockscout frontend, configured by `frontend-public.json` and `envs.js` (the two must match; `launch-frontend.cjs` refuses to start otherwise) |

The images are built locally (see [`build/`](../build/) and [`BLOCKSCOUT_IMAGE_PROVENANCE.md`](BLOCKSCOUT_IMAGE_PROVENANCE.md)); `pull_policy: never` prevents any registry pull. A copy of all six images is kept on the offline backup disk.

## Secrets

`server/.env` (mode 600, never committed) holds `POSTGRES_PASSWORD` (Blockscout database, also used by the stats reader account), `STATS_POSTGRES_PASSWORD` and `SECRET_KEY_BASE`. Compose reads it automatically from the folder.

## Update a service

```bash
cd /srv/kcalb/applications/xitchain-evm-explorer
docker compose -f compose.json config --quiet          # check first
docker compose -p xitchain-evm-explorer -f compose.json up -d <service>
```

Then check `https://evm-explorer-testnet.xitchain.com/`, `/address/<any address>`, `/tx/<hash>`, `/block/1` and `/api/v2/stats`.

Do not expose Docker ports directly and do not reuse old explorer directories, databases or volumes.
