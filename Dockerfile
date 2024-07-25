FROM python:3.11-alpine

ENV PYTHONUNBUFFERED=1

COPY ./requirements.txt /requirements.txt
COPY ./app /app

WORKDIR /app
EXPOSE 8000

# Gerekli paketleri yükle
RUN apk update && \
    apk add --no-cache gcc musl-dev linux-headers postgresql-dev

# Kullanıcı oluştur
RUN adduser -D app

# Sanal ortam oluştur ve bağımlılıkları yükle
RUN python -m venv /py && \
    /py/bin/pip install --upgrade pip && \
    apk add --update --no-cache postgresql-client && \
    apk add --update --no-cache --virtual .tmp-deps \
        build-base postgresql-dev musl-dev && \
    /py/bin/pip install -r /requirements.txt && \
    apk del .tmp-deps && \
    mkdir -p /vol/web/static && \
    mkdir -p /vol/web/media && \
    chown -R app:app /vol && \
    chmod -R 755 /vol
    

ENV PATH="/py/bin:$PATH"


USER app