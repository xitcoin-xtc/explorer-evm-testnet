# Xitchain EVM Testnet Explorer

Configuration and build recipes of the public EVM explorer of the Xitcoin testnet (Xitchain), exactly as it runs.

## Network

| Property | Value |
|---|---|
| Network | Xitcoin Testnet |
| EVM chain ID | `101089` |
| Native currency | XTC |
| Decimals | 18 |
| Explorer | https://evm-explorer-testnet.xitchain.com/ |
| JSON-RPC | https://evm-rpc-testnet.xitchain.com/ |
| Faucet | https://faucet-testnet.xitchain.com/ |
| Project | https://xitcoin.com/chain/ |

Cosmos-style and EVM-style addresses coexist on Xitcoin Testnet. This does not imply a bridge or a second token: XTC is the native asset exposed through both interfaces.

Public network configuration: [`xitcoin-xtc/testnets`](https://github.com/xitcoin-xtc/testnets). Node software: [`xitcoin-xtc/pos-chain`](https://github.com/xitcoin-xtc/pos-chain).

## What is in this repository

| Folder | Content |
|---|---|
| [`server/`](server/) | The explorer's deployment folder, file for file as on the server (`/srv/kcalb/applications/xitchain-evm-explorer`), except that passwords live in `.env` (template: [`server/.env.example`](server/.env.example)). |
| [`build/`](build/) | How the backend and frontend images were built (13/09/2026), and the frontend fix of 21/11/2026 is in `server/frontend-fix.Dockerfile`. |
| [`docs/`](docs/) | Deployment notes, image provenance, frontend configuration, API reference. |

The explorer is Blockscout: backend 11.2.8 (indexer + API), stats service 2.19.1, frontend, PostgreSQL 17 (two databases) and Redis 7. Every port is bound to `127.0.0.1`; nginx on the host serves `https://evm-explorer-testnet.xitchain.com`. See [`docs/DEPLOYMENT.md`](docs/DEPLOYMENT.md).

## Validate

```bash
cd server
cp .env.example .env   # then fill in the values
docker compose -f compose.json config --quiet
```

The `.env` file is never committed.

## API

The public API reference is stored at [`docs/api/xitcoin-testnet-api-v2.json`](docs/api/xitcoin-testnet-api-v2.json).

## Image provenance

See [`docs/BLOCKSCOUT_IMAGE_PROVENANCE.md`](docs/BLOCKSCOUT_IMAGE_PROVENANCE.md).

## Security

Security reports follow [`SECURITY.md`](SECURITY.md).

## License

Original Xitcoin-authored configuration and documentation are available under the [MIT License](LICENSE). Blockscout components retain their upstream terms; see [third-party notices](THIRD_PARTY_NOTICES.md).
