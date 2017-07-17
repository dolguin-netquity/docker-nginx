FROM python:3.5.3
ENV PYTHONBUFFERED 1
ENV TERM screen-256color
ENV PYTHONPATH=/app/src
ENV DJANGO_SETTINGS_MODULE=config.settings.production
ENV BASE_DIR=/app/src
EXPOSE 8000
WORKDIR /app
CMD ["gunicorn", "--access-logfile", "-", "--bind", "0.0.0.0:8000", "config.wsgi:application"]
RUN mkdir -p /app/var/log
ONBUILD ADD requirements.txt setup.cfg .pylintrc /app/
ONBUILD RUN pip install -U pip && pip install -r requirements.txt && rm -rf /root/.cache
ONBUILD ADD src /app/src
