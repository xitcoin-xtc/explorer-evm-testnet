# Blockscout frontend configuration

The frontend reads its public settings from two files in [`server/`](../server/), mounted read-only into the container:

- `frontend-public.json`: used by the server side;
- `envs.js`: the same values for the browser (`window.__envs`).

They must contain exactly the same keys and values: `launch-frontend.cjs` refuses to start if they differ. Change both together, then recreate the `frontend` service.

Main settings: network name `Xitcoin Testnet`, chain ID `101089`, currency XTC (18 decimals), testnet flag, API and app host `evm-explorer-testnet.xitchain.com`, stats service under `/stats-service`, MetaMask as wallet, no ads, no gas tracker.

Logo and icon: `NEXT_PUBLIC_NETWORK_LOGO` and `NEXT_PUBLIC_NETWORK_ICON` are set, and the frontend reads them from `/assets/configs/network_logo.svg` and `/assets/configs/network_icon.svg`; both are mounted from `server/network_logo.svg` (the Xitcoin symbol of xitcoin.com, `assets/brand/xitcoin/symbol-color-for-light-bg.svg`). No source patch is applied for branding. Image-level fixes (icon sprite, missing module link) are listed in [`BLOCKSCOUT_IMAGE_PROVENANCE.md`](BLOCKSCOUT_IMAGE_PROVENANCE.md).
