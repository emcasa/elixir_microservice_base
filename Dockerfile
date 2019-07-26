FROM elixir:1.9.0
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

# elixir install deps
RUN mix local.hex --force \
    && mix local.rebar --force

# set env vars
ARG ENV
ENV ENV=$BUILD_ENV

ARG MIX_ENV
ENV MIX_ENV=$BUILD_MIX_ENV

ARG TIMBER_API_KEY
ENV TIMBER_API_KEY=$BUILD_TIMBER_API_KEY

ARG TIMBER_SOURCE_ID
ENV TIMBER_SOURCE_ID=$BUILD_TIMBER_SOURCE_ID

ARG PROMETHEUS_USER
ENV PROMETHEUS_USER=$BUILD_PROMETHEUS_USER

ARG PROMETHEUS_PASS
ENV PROMETHEUS_PASS=$BUILD_PROMETHEUS_PASS

# app set workdir
WORKDIR /opt/emcasa/elixir_microservice_base

# app install deps
COPY mix.exs mix.exs
COPY mix.lock mix.lock

# NOTE (jpd): there must be a better way to do this
RUN mix deps.get \
    && mix deps.compile

# app copy code
COPY . /opt/emcasa/elixir_microservice_base
RUN mix compile

# app expose server port
EXPOSE 80

# execution copy scripts
ENTRYPOINT ["mix"]
CMD ["server"]
