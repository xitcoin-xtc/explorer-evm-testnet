# Xitchain EVM explorer, display (frontend), 21/11/2026.
# The 13/09 image lacks the link from @wagmi/core to @tanstack/query-core (both are in the image), so every
# /address/ page crashed with error 500. This is the same image plus that link.
FROM xitcoin-private/frontend:20260913T0911
RUN W=$(ls -d /app/node_modules/.pnpm/@wagmi+core@2.22.1*/node_modules) \
 && mkdir -p "$W/@tanstack" \
 && ln -sfn /app/node_modules/.pnpm/@tanstack+query-core@5.55.4/node_modules/@tanstack/query-core "$W/@tanstack/query-core" \
 && test -f "$W/@tanstack/query-core/package.json"
