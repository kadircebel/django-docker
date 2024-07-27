# Django & Nginx Docker example

## Installation

You have to install docker and docker compose your server.

NOTE!!!
* you should update nginx port number to your server in docker-compose-deploy.yml.

```bash
# docker-compose-deploy.yml
proxy:
    build:
      context: ./proxy
    restart: always
    depends_on:
      - app
    ports:
      - 88:8000
    volumes:
      - static-data:/vol/static
```

```bash
git clone https://github.com/kadircebel/django-docker.git
```

## .env file configuration

You should update for your own server.

```python
cp .env.sample .env

# edit .env file
nano .env

```

## .env file edit configuration

```python
DB_NAME=dbname
DB_USER=rootuser
DB_PASS=dbpass
SECRET_KEY=django_secret_key
ALLOWED_HOSTS=127.0.0.1, test.domain.com, test124.domain.com, etc.
```
## running docker-compose

```python
docker compose -f docker-compose-deploy.yml up -d

# test purpose
docker compose -f docker-compose-deploy.yml run --rm app sh -c "python manage.py createsuperuser"
```

Please make sure to update tests as appropriate.

## License

[MIT](https://choosealicense.com/licenses/mit/)