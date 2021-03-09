FROM bitwalker/alpine-elixir-phoenix:1.10.3

ENV MIX_ENV dev

WORKDIR /app
COPY . /app/

RUN mix do local.hex --force, local.rebar --force

COPY config/ /app/config/
COPY mix.exs /app/
COPY mix.* /app/

COPY apps/gen_pg_pooling/mix.exs /app/apps/gen_pg_pooling/
COPY apps/gen_pg_pooling_web/mix.exs /app/apps/gen_pg_pooling_web/

RUN mix do deps.get, deps.compile

WORKDIR /app/apps/gen_pg_pooling_web
RUN mix compile
RUN npm install --prefix ./assets
RUN mix phx.digest

WORKDIR /app

EXPOSE 4000
CMD ["mix", "phx.server"]