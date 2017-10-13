FROM python:3.5.4-jessie
ENV PYTHONBUFFERED 1
ENV TERM screen-256color
ENV PYTHONPATH=/app/src
ENV DJANGO_SETTINGS_MODULE=config.settings.production
ENV BASE_DIR=/app/src
EXPOSE 8000
WORKDIR /app
CMD ["gunicorn", "--access-logfile", "-", "--bind", "0.0.0.0:8000", "config.wsgi:application"]
RUN \
  echo 'deb http://apt.postgresql.org/pub/repos/apt/ jessie-pgdg main' \
    > /etc/apt/sources.list.d/postgresql.list \
  && wget --quiet -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc \
    | apt-key add - \
  && apt-get update && apt-get install -y --no-install-recommends \
    postgresql-client-9.5 \
  && rm -rf /var/lib/apt/lists/*
RUN mkdir -p /app/var/log
