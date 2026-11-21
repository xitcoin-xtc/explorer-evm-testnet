# Build only in a private context with an acquired, received base; no default digest.
ARG NODE_BASE
FROM ${NODE_BASE}
WORKDIR /app
ADD frontend-corrected-runtime.tar.gz /app/
COPY launch-frontend.cjs /app/launch-frontend.cjs
ENV NODE_ENV=production HOSTNAME=0.0.0.0 PORT=3000
ENTRYPOINT ["node", "/app/launch-frontend.cjs"]
