# qualified_frontend is supplied as an OCI layout context pinned to cbdb7e42...;
# see frontend-asset-oci-build.command.sh. No registry lookup is needed.
FROM qualified_frontend
COPY --chmod=0644 sprite.svg /app/public/icons/sprite.svg
LABEL xitcoin.mission=20260913T0911 xitcoin.correction=missing-icon-sprite
