FROM debian:12

ARG PLEROMA_VER
ARG UID
ARG GID
ENV MIX_ENV=prod

RUN apt update \
    && apt --yes full-upgrade

RUN apt --yes install git build-essential postgresql-client cmake libmagic-dev ash
RUN apt --yes install elixir erlang-dev erlang-nox
RUN apt --yes install imagemagick ffmpeg libimage-exiftool-perl libvips-tools

RUN mkdir /pleroma
RUN addgroup --gid ${GID} pleroma 
RUN adduser --home /pleroma --no-create-home --shell /bin/false --disabled-password --gecos "" --gid ${GID} --uid ${UID} pleroma
RUN chown pleroma:pleroma /pleroma

ARG DATA=/var/lib/pleroma
RUN mkdir -p /etc/pleroma \
    && chown -R pleroma /etc/pleroma \
    && mkdir -p ${DATA}/uploads \
    && mkdir -p ${DATA}/static \
    && chown -R pleroma ${DATA}

USER pleroma
WORKDIR /pleroma

RUN git clone --branch ${PLEROMA_VER} --single-branch https://git.pleroma.social/pleroma/pleroma.git /pleroma

RUN echo "import Mix.Config" > config/prod.secret.exs \
    && mix local.hex --force \
    && mix local.rebar --force \
    && mix deps.get --only prod \
    && mkdir release \
    && mix release --path /pleroma

USER pleroma
EXPOSE 4000
CMD  ["/pleroma/docker-entrypoint.sh"]