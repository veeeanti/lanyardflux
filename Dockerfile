FROM elixir:1.19-alpine AS build

RUN apk add --no-cache git build-base

ENV MIX_ENV=prod

WORKDIR /app

# get deps first so we have a cache
ADD mix.exs mix.lock /app/
RUN \
	cd /app && \
	mix local.hex --force && \
	mix local.rebar --force && \
	mix deps.get --only prod

# then make a release build
ADD . /app/
RUN \
	mix compile && \
	mix release

FROM alpine:3.20

RUN apk add --no-cache openssl libstdc++ curl

WORKDIR /app

COPY --from=build /app/_build/prod/rel/lanyard /opt/lanyard

EXPOSE 4001

HEALTHCHECK --interval=30s --timeout=10s --start-period=5s --retries=3 \
  CMD curl -f http://localhost:4001/ || exit 1

CMD [ "/opt/lanyard/bin/lanyard", "start" ]
