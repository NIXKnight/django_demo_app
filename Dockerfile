FROM debian:bookworm-slim AS base

ARG DEBIAN_FRONTEND noninteractive

# Locales
ENV LANG=en_US.UTF-8
ENV LANGUAGE=en_US:en
ENV LC_ALL=en_US.UTF-8

ENV VIRTUAL_ENV=/opt/django_demo_app_venv
ENV PATH=${VIRTUAL_ENV}/bin:${PATH}

ENV PYTHONDONTWRITEBYTECODE 1

WORKDIR /opt/django_demo_app

RUN useradd -m --shell /bin/false django_demo_app

RUN set -eux; \
    { \
      echo "locales locales/default_environment_locale select en_US.UTF-8"; \
      echo "locales locales/locales_to_be_generated multiselect en_US.UTF-8 UTF-8"; \
    } | debconf-set-selections; \
    apt-get update; \
    apt-get -y dist-upgrade; \
    apt-get -y install --no-install-recommends \
      python3 \
      python3-venv \
      python3-pip \
      libmariadb3 \
      locales; \
    apt-get clean all; \
    rm -rf /var/lib/apt/*

FROM base AS builder-tools

RUN set -eux; \
    apt-get update; \
    apt-get -y install --no-install-recommends pkg-config build-essential python3-dev default-libmysqlclient-dev

FROM builder-tools AS builder

COPY requirements.txt requirements.txt

RUN set -eux; \
python3 -m venv "${VIRTUAL_ENV}"; \
pip install -r requirements.txt

FROM base AS production

COPY --from=builder ${VIRTUAL_ENV} ${VIRTUAL_ENV}
COPY . .

USER django_demo_app

CMD [ "gunicorn", "django_demo_app.wsgi:application" ]
