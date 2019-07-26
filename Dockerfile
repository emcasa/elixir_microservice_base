FROM elixir:1.9.0

ENV MIX_ENV=prod \
    LANG=C.UTF-8

ARG BUILD_DATE
ARG VCS_REF

LABEL maintainer="EmCasa <dev@emcasa.com>" \
      org.opencontainers.image.title="Elixir Microservice Base repo for EmCasa." \
      org.opencontainers.image.description="Elixir Microservice Base repo for EmCasa." \
      org.opencontainers.image.authors="EmCasa <dev@emcasa.com>" \
      org.opencontainers.image.licenses="MIT" \
      org.opencontainers.image.source="https://github.com/emcasa/elixir_microservice_base" \
      org.opencontainers.image.revision=$VCS_REF \
      org.opencontainers.image.created=$BUILD_DATE

# Set env vars
ARG BUILD_PORT
ENV PORT=$BUILD_PORT

ARG BUILD_TIMBER_SOURCE_ID
ENV TIMBER_SOURCE_ID=$BUILD_TIMBER_SOURCE_ID

ARG BUILD_TIMBER_API_KEY
ENV TIMBER_API_KEY=$BUILD_TIMBER_API_KEY

ARG BUILD_PROMETHEUS_USER
ENV PROMETHEUS_USER=$BUILD_PROMETHEUS_USER

ARG BUILD_PROMETHEUS_PASS
ENV PROMETHEUS_PASS=$BUILD_PROMETHEUS_PASS

ARG BUILD_SENTRY_DSN
ENV SENTRY_DSN=$BUILD_SENTRY_DSN

# elixir install deps
RUN mix local.hex --force \
    && mix local.rebar --force

# app set workdir
RUN mkdir -p /app
WORKDIR /app

# copy files
COPY config ./config
COPY lib ./lib
COPY mix.exs .
COPY mix.lock .

# install deps
RUN mix deps.get \
    && mix deps.compile

# build release
RUN mix release

ENTRYPOINT ["./_build/prod/rel/elixir_microservice_base/bin/elixir_microservice_base"]
CMD ["start"]
