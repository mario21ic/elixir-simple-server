FROM bitwalker/alpine-elixir:1.9 as build
WORKDIR /app
COPY ./ /app
RUN export MIX_ENV=prod && \
    rm -Rf _build/ && \
    mix deps.get --only=prod && \
    mix release

#FROM pentacent/alpine-erlang-base:latest
FROM bitwalker/alpine-elixir:1.9
WORKDIR /opt/app/
COPY --from=build /app/_build/prod/rel/simple_server/ ./
#USER default
EXPOSE 8085
ENV REPLACE_OS_VARS=true \
    PORT=8085
CMD ["/opt/app/bin/simple_server", "start"]
